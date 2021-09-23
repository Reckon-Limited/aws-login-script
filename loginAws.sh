set -e

profile=$1
if [ -z "$profile" ];
then
  read -p 'Please enter you AWS profile: ' profile
fi

session_name=$(aws --profile $profile configure get role_session_name) || true
if [ -z "$session_name" ];
then
  session_name="loginAws-session"
fi

role_arn=$(aws --profile $profile configure get role_arn)
mfa_serial=$(aws --profile $profile configure get mfa_serial)

echo "Note: MFA characters are not shown when typing"
credentials=$(aws sts assume-role --duration-seconds 3600 --role-arn $role_arn --role-session-name $session_name --profile $profile)

id=$(jq -r '.Credentials.AccessKeyId' <<< "$credentials")
secret=$(jq -r '.Credentials.SecretAccessKey' <<< "$credentials")
token=$(jq -r '.Credentials.SessionToken' <<< "$credentials")

if [ -z "$id" ] || [ -z "$secret" ] || [ -z "$token" ]; 
then
  echo "Failed to set AWS credentials"
  exit 1
fi

export AWS_ACCESS_KEY_ID=$id
export AWS_SECRET_ACCESS_KEY=$secret
export AWS_SESSION_TOKEN=$token
echo "AWS Credentials set"