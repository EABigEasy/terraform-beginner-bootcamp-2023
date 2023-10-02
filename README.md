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

## Terraform Basics

### Terraform Registry

Terraform sources their Providers and modules from the terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

-**Providers** -Interface to APIs that will allow to create resourdces in terraform.

- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

#### Terraform Console
We can see a list of all Terraform Commands by simply typing `terraform`

#### Terraform Init

`terrform init`

At the start of  a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project


#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset i.e "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag e.g
`terraform apply --auto-approve`

#### Terraform Destroy

We can use the `terraform destroy` to destroy resources created.
If we want to automatically approve to destroy  we can also  provide the auto approve flag e.g
`terraform destroy --auto-approve`

**Remember do not commit aws credentials(Access_key_id, Secret_access_key and default_region) to your repository. Delete after Terraform destroy**

#### Terrafrom Lock Files

`.terraform.lock.hcl` contains the  locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version COntrol System (VSC) e.g Github

### Terraform State Files
`.terraform.tfstate` contain information about the current state of your infrastructure. This file **should not be commited** to your VCS. This file can contain sensitive data.

If you lose this fule, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers ,


## AWS Provider
 There are rules to including AWS provider in the `main.tf` file. 

 **Note** you can't add two terraform blocks, include the aws provider block in the main terraform block.

 
[AWS Provider DOCS](https://registry.terraform.io/providers/hashicorp/aws/latest)


### AWS S3 Bucket Naming rules

When creating s3 Bucets, there are naming conventions to follow. Update your resource block eg
```
resource "random_string" "bucket_name" {
  lower=true
  upper =false
  length   = 16
  special  = false
}

```

**Note** AWS Credentials must have right permission to create resources from terraform to aws, so as to to avoid Permissions Denied.

[AWS DOCS on S3 Naming convention](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnaming)

[Terraform S3 DOCS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

## Issues with Terrraform CLoud and Gitpod Workspace

When attemoting to run `terraform login` it will launch a bash a wiswig view to generate a token. However it doesnt work expected in Gitpod VsCode in the browser

#### Solution

The Workaround is manually generate a token in Terraform Cloud.

```
https://app.terraform.io/app/settings/tokens?source=terraform-login

```
Then Create the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```
Provide the following code (replace your token in the file):

```json
{
 "credentials": {
   "app.terraform.io":{
    "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
  }
 }
}

```

We have automated the process using bash script.
[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

