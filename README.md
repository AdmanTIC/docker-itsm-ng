# ITSM-NG Docker project 


## Quick reference
* Mainted by:
[AdmanTIC](https://www.admantic.fr/)

* Useful ressources:
[PHP Docker Hub page](https://hub.docker.com/_/php), [ITSM-NG Github](https://github.com/itsmng/itsm-ng) [ITSM-NG official Wiki](https://wiki.itsm-ng.org/),


## What is ITSM-NG?
![ITSM-NG logo](./pictures/itsm-ng.png)

The ITSM-NG project is a community-driven initiative to enhance and extend the capabilities of GLPI to provide a more comprehensive and feature-rich IT service management solution. The fork aims to align the software with the latest ITIL best practices and guidelines.  [Source](https://www.itsm-ng.org/)


## Description
This project provides an easy way to build and run an ITSM-NG instance with a MariaDB database using Docker.

This image is based on the official php-apache image [PHP Docker Hub official page](https://hub.docker.com/_/php) and inherits all its variables.   




## Features
- build an ITSM-NG image using a Dockerfile
- deploy an ITSM-NG instance with MariaDB using Docker-compose

## How to use this image
- This image needs a MariaDB >= 10.X or MySQL >= 5.7 instance to run properly


### Variables
| **Variable**       | **Usage**                             |
|---------------------|---------------------------------------|
| `DBDATABASE`          | database name                         |
| `DBUSER`              | name of the database user             |
| `DBPASSWORD`          | Database password                     |
| `DBHOST`              | Host on which the database is running |
| `ITSM_ADMIN_PASSWORD` | Password for the default admin 'itsm' |

### Volumes
| **Volume location** | **/var/www/html/files** |
|---------------------|-------------------------|