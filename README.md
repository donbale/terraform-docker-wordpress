# Terraform / Docker / Wordpress

Simple way to bring up a local development environment for Wordpress using Terraform and Docker.

## Description

The simplest way to create a Wordpress install on your local machine for development purposes. Builds with Terraform (IaC) to pull down Wordpress and MySQL docker images and connect with a docker network. Docker volumes is utilized to provide persistant storage. 

## Getting Started

### Dependencies

* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [Docker](https://docs.docker.com/get-docker/)

### Installing

* Cone the repository

### Executing 

```
terraform plam -out=tfplan -input=false

```
```
terraform apply -input=false tfplan

```

* Your install will be available at localhost:80

## Authors

Contributors names and contact info

Christopher Bale 
[www.christopherbale.com](https://christopherbale.com)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the "Do what you will, just dont blame me" License 

## Acknowledgments

