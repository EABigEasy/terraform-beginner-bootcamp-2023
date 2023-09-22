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

### Refactoring into Bash scripts
While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts teps were a considerable amount more code. so we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute  manually Terraform CLI install
_ THis will allow better portablity for other projects that need to install Terraform CLI


### Shebang Considerations

A shebang (pronounced Sha-bang) tells the bash script t=what program that will interpret the scruot e.g `#!/bin/bash`
ChatGPT recommended this format for bash : `#!/usr/bin/env bash`

-for portability for different OS distributions
- will search the user's PATH for the bash executable

### Execution Considerations
When executing the bash script we can use then`./` shorthanfnotiation to execute the bash script.
e.g `./bin/install_terraform_cli.sh`

### Linux Permissions COnsiderations

In order to make our bash script executable we need to change linux permission for the fix to be executable at the user mode

chmod u+x ./bin/install_terraform_cli.sh
[](https://en.wikipedia.org/wiki/Shebang_(Unix))
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun 
https://www.gitpod.io/docs/configure/workspaces/tasks
