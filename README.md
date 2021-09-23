# aws-login-script
This is a script that can we used to login to AWS and pass the credentials through to other code.

## Usage

This script accepts one parameter which is the name of the AWS profile you want to assume. Here is an example of calling the script:

`./loginAws.sh dev-profile`

After the script has assumed the role it passes the credentials into the environment it is running in. Here are a couple of examples of how other code can use these credentials:

`. ./loginAws.sh dev-profile && npm start` or `source ./loginAws.sh dev-profile && npm start`

Or, in the same terminal session you can run the commands seperately:

```
./loginAws.sh dev-profile
npm start
```

The script run via npm start will then have access to the AWS credentials.

Optionally you can leave the profle name blank when calling the script and it will prompt you for the profile name.
