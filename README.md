# TF-modules

## About
Terraform modules

### Usage

```
// Basic Usage

module "example" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//<module>?ref=main
  ...
}

// Target Specific Release

module "example" {
  source = "git::https://github.com/GemeenteRotterdam/TF-modules.git//KeyVault?ref=19-08-2025
  ...
}

```

### Branching

In order to make changes create a new branch like:

- {personeelsnummer}-feature-branch-{description}


### Merging

After completing and testing the changes open a pull request to merge into the target branch.
The changes will be reviewed.

### Releasing

Pull requests to the main branch always warrant the creation of a new release.
This is because the changes may break any existing configuration which is already running in a production environment. It is reccommended to target a specific release when using modules from this repository.