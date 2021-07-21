# install docker provider from source and configure
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

# define persistant docker volume resources for both wordpress and database data

resource "docker_volume" "db_data" {}

resource "docker_volume" "wp_data" {}

# define docker network resource for container communication

resource "docker_network" "wordpress_net" {
  name = "wordpress_net"
}

# define wordpress docker container resource

resource "docker_container" "db" {
  image   = "mysql:5.7"
  name    = "db"
  restart = "always"
  #connects to docker network
  network_mode = "wordpress_net"
  #ensures above docker network is created before container so apply doesn't fail on delay
  depends_on = [docker_network.wordpress_net]
  env = [
    "MYSQL_ROOT_PASSWORD=wordpress",
    "MYSQL_PASSWORD=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_DATABASE=wordpress"
  ]
  #mounts docker volume to ensure database persistant on restarts
  mounts {
    type   = "volume"
    target = "/var/lib/mysql"
    source = "db_data"
  }
}

#define wordpress docker container resource 
resource "docker_container" "wordpress" {
  image   = "wordpress:latest"
  name    = "wordpress"
  restart = "always"
  #connects to docker network
  network_mode = "wordpress_net"
  #ensures above docker network is created before container so apply doesn't fail on delay
  depends_on = [docker_network.wordpress_net]
  env = [
    "WORDPRESS_DB_HOST=db:3306",
    "WORDPRESS_DB_NAME=wordpress",
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_PASSWORD=wordpress"
  ]
  #mounts docker volume to ensure saved files are persistant on restarts
  mounts {
    type   = "volume"
    target = "/var/www/html"
    source = "wp_data"
  }
  #portmapping
  ports {
    internal = 80
    external = 80
  }
}

