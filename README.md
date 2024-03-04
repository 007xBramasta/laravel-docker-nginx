<h1 style="text-align:center">Laravel Project Setup With Docker</h1>

## Brief Description
Create an environment to learn how to build a containerized Laravel development environment using Docker.

You just need to clone this repo and run docker compose up -d to get everything.

## Requirements

- Docker
- NodeJS LTS ^18
- Shell (WSL2, MacOS, or Linux)

## Some of the services are
- laravel
- nginx
- pgsql 
  

## Quick Start
Make sure your docker engine is running
- Clone project to local
  
  git clone https://github.com/marselhr/laravel-with-docker.git laravel/app
  
- Navigate project folder
  
  cd laravel/app
  
- Build a services
  
  docker compose up -d
  
- Install dependencies
  
  ./install.sh -i
  
- Create app key
  
  docker exec app php artisan key:generate
  
- Access [localhost](http://localhost) and now you have the fresh laravel app
Thanks😊
