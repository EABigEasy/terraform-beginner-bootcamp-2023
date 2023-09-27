# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:
 This Project is going to utilize semantic versioning for it's tagging.

[semver.org](https://semver.org/)

 The general format :

**MAJOR.MINOR.PATCH**,e.g .`1.0.1` 

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI



### Considerations with the Terraform CLI Changes
The Terraform CLI Installation instructions have changed to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terrafrom Documentation and change the scripting for install.

[Install Terraform CLI ](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution
This Project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.
[How to check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version:
```
$cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

### Refactoring into Bash scripts
While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute  manually Terraform CLI install
_ THis will allow better portablity for other projects that need to install Terraform CLI.

### Shebang Considerations

A shebang (pronounced Sha-bang) tells the bash script what program that will interpret the scruot e.g `#!/bin/bash`

ChatGPT recommended this format for bash : `#!/usr/bin/env bash`

- for portability for different OS distributions
- will search the user's PATH for the bash executable

(https://en.wikipedia.org/wiki/Shebang_(Unix)


### Execution Considerations
When executing the bash script we can use then`./` shorthanfnotiation to execute the bash script.
e.g `./bin/install_terraform_cli.sh`

If we are using a script in  .gitpod.yml we need to point the script to a program to interpret it.

e.g. `source ./bin/install_terraform_cli.sh`

### Linux Permissions COnsiderations

In order to make our bash script executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli.sh
```
alternatively:

```sh
chmod 744 ./bin/install_terraform_cli.sh
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### env command
We can list out all Environment Variables( Env VArs) using the `env` command.

We can Filter specific env vars using grep e.g `env | grep AWS `

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world' `

In the terminal we unset using `unset Hello`

we can set an env var temporarily when just running a command
```sh
HELLO ='world' ./bin/print_message
```
Within a bash script we can set env without writing export e.g

```sh
#!/usr/bin/env bash
Hello = 'world' 

echo $HELLO
```

## Printing Vars

We can print an Env Var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up  new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`


#### Persisting Env Vars in Gitpod 
We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'

```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non sensitive env vars.

### AWS CLI installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install (AWS CLI) ] (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env vars] (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correclty by running the following command.

```sh

aws sts get-caller-identity

```

If it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDAXAWFCTKFJSPSPHE2Z",
    "Account": "2574788457755",
    "Arn": "arn:aws:iam::2574788457755:user/terraform-begineer-bootcamp"
}

```

We'll need to generate AWS CLI crendentials from IAM User in order to the user AWS CLI