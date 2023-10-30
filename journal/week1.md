# Terraform Bootcamp 2023 -week 1


## Root Module Structure

Our root module structutre is as follows:



```
PROJECT_ROOT
|
|-- main.tf            # everything else
|-- variables.tf       # stores the structure of input variables
|-- terraform.tfvars   # the data of variables we want to load into our terraform
|-- providers.tf       # defined required providers and their configuration
|-- outputs.tf         # stores our outputs
|-- README.md          # required for root modules


```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform we cans et two kind of variables
- Environment Variables - those you would set in your bash terminal e.g AWS Credentials

- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud Variables to be sensitive so they are not shown visibly in the UI.


### LoadingTerraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

We can use the `-var` flag to set an input variable or override a varibale in the tfvars file e.g `terraform -var.user_uuid="my-user-id"`.

### var-file flag

the var-file flag is used to specify variable values in a separate variables file using the -var-file flag. This is especially useful when you have a large number of variables to set, or you want to store your variable values in a separate, version-controlled file.  Example of how it's used.
```sh
terraform apply -var-file="variables.tfvars"

```
[Terraform Commands](https://developer.hashicorp.com/terraform/cli/commands/)
### terraform.tfvars

This is the default file to load in terraform variables in bulk

### auto.tfvars

`auto.tfvars` is a file used in Terraform to automatically load variable values without requiring the user to explicitly specify them through the command line or a variable definition file. This can be useful for keeping sensitive or default values outside of your main Terraform configuration files.
```hcl
# auto.tfvars

access_key = "your-access-key"
secret_key = "your-secret-key"
region     = "us-east-1"

```

[Terraform Commands](https://developer.hashicorp.com/terraform/cli/commands/)

### Order of Terraform Varibales

This is the order of precedence of Variables in Terraform
The order of precedence for variables in Terraform can be summarized as follows, from highest to lowest precedence:

1. Command-Line Flags.
2. Environment Variables.
3. Terraform Configuration Files.
4. Default Values.

[Terraform Commands](https://developer.hashicorp.com/terraform/cli/commands/)


## Dealing with Configuration Drift

## What happens if you lose state file?

You most likely have to tear don all your cloud infrastructure manually. You can use terraform import but it won't work for all cloud resources. check Terraform documentation for resources that support import.
### Fix Missing Resources with Terraform Import
if older  terraform version
`terraform import aws_s3_bucket.bucket bucket-name`

***Note: to import from s3, Due to newer version, we use the import block of s3 to import from aws s3, not the import s3 command***
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps, running terraform plan is with attempt to put infrastructure back into the expected state fixing the drift. 

**Note:Terraform is really good with configuration drift, if you delete a bucket, it automatically creates the bucket when you run `terraform plan` again. A slong as the file are not deleted e.g main.tf, variables.tf, outputs.tf, proviers.tf. ***

## Fix using Terraform Refresh

```tf
terrsform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure
 It is recommended to place modules in a `modules` directory when locally developing modules but you can name it what you like.
### Passing Input Variables

We can pass input variables to our module.
The Module has to declare the terraform variables in its own variables.tf 
like we did modules/terrahouse_aws folder consits of main.tf, output.tf, variables.tf

```tf
module "terrahouse_aws" {
  source="./modules/terrahouse_aws"
  user_uuid=var.user_uuid
  bucket_name=var.bucket_name
}
```

### Modules Sources
Using the source we can import the module from varioys places e.g
-locally
-GitHub
-Terraform Registry 

```tf
module "terrahouse_aws" {
  source="./modules/terrahouse_aws"
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

**NOTE: Everything in modules folder must match the top level, files like main.tf, variables.tf in the main folder**