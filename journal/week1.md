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

## What happens if we lose our state file?
If you lose your state file, you most likely have to tear down all your cloud infrastructure 

You can use terraform import but it won't work for all cloud resources you need to check the terraform providers documentation for which resources import supports.

### Fix Missing Resources with Terraform Import
`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

### Fix Manual COnfiguration

If someone goes and delete or modifies or modifies cloud resource manually through clickops

Terraform plan. If we run teraform plan, it attempts to put our infrastructure back into the expected stae fixing configuration Drift.