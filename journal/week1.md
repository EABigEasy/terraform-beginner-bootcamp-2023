# Terraform Bootcamp 2023 -week 1


## Root Module Structure

Our root module structutre is as follows:



```
PROJECT_ROOT
|
|-- variables.tf       # stores the structure of input variables
|-- main.tf            # everything else
|-- providers.tf       # defined required providers and their configuration
|-- outputs.tf         # stores our outputs
|-- terraform.tfvars   # the data of variables we want to load into our terraform
|-- README.md          # required for root modules


```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
