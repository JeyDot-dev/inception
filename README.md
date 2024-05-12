# Inception

## Project Overview
This project aims to set up a small infrastructure composed of different services under specific rules, all within a virtual machine environment. The infrastructure is managed using Docker Compose, ensuring each service runs in a dedicated container.

## Project Requirements
- Dockerfiles must be written for each service and called in the docker-compose.yml by the Makefile.
- Ready-made Docker images are forbidden except for Alpine/Debian.
- Services include:
  - NGINX with TLSv1.2 or TLSv1.3 only.
  - WordPress + php-fpm.
  - MariaDB.
- Two volumes are required:
  - One for WordPress database.
  - Another for WordPress website files.
- A docker-network must be established to connect the containers.
- Containers must restart in case of a crash.
- Prohibited practices include:
  - Use of 'tail -f' or similar hacks.
  - Use of 'network: host' or '--link'.
  - Containers started with a command running an infinite loop.
  - Use of 'latest' tag.
  - Presence of passwords in Dockerfiles.
- Environment variables must be used, and it is recommended to use a .env file and Docker secrets for storing confidential information.
- NGINX container must be the only entry point into the infrastructure via port 443 using TLSv1.2 or TLSv1.3 protocol.
- In the WordPress database, there must be two users, one being the administrator whose username cannot contain 'admin' or 'administrator'.
- Volumes will be available in the /home/login/data folder of the host machine using Docker, where 'login' should be replaced with the user's login.

## Getting Started
1. Clone this repository to your local machine.
2. Ensure Docker and Docker Compose are installed on your system.
3. Fill the .env file in srcs/.env aswell as the secret files [.txt]
4. Run `make` to build and start the containers.
5. Access your infrastructure via port 443 using TLSv1.2 or TLSv1.3 protocol.

## Project Structure
```
.
├── Makefile
├── secrets
│   ├── db_name.txt
│   ├── db_password.txt
│   ├── db_user.txt
│   ├── wp_admin_email.txt
│   ├── wp_admin_name.txt
│   ├── wp_admin_password.txt
│   ├── wp_user_email.txt
│   ├── wp_user_name.txt
│   └── wp_user_password.txt
└── srcs
    ├── docker-compose.yaml
    └── requirements
        ├── mariadb
        │   ├── Dockerfile
        │   ├── conf
        │   │   └── mariadb-server.cnf
        │   └── script
        │       └── setup_db.sh
        ├── nginx
        │   ├── Dockerfile
        │   └── conf
        │       ├── nginx.conf
        │       └── nginx.conf.old
        └── wordpress
            ├── Dockerfile
            ├── config
            │   └── www.conf
            └── script
                └── set_wp.sh
```

## Notes
- Dont forget to fill .env and secret files
