# Time Management

## CI statuses

[![Heroku Deployment](https://github.com/malusiTowo/TimeManager-epitech/workflows/heroku-deployment/badge.svg)](https://github.com/malusiTowo/TimeManager-epitech/actions)

## Description

This project is the web client of the time management epitech project. This project is built with [Vue](https://vuejs.org/). This project is a time management system for employees, managers and adminstrators. You can enter working times for employees and they can clock-in and clock-out of work. All the data is then collected and presented in data graphs.


## Scripts

## Run

Run the following command to run the entire project in development environment.

```
$ docker-compose -f docker-compose.dev.yml up --build
```

Run the following command to run the entire project in production environment.

```
$ docker-compose up --build
```

## Backend

Check out the backend [Readme](server/readme.md)

## Web Client

Check out the backend [Readme](client/readme.md)


## Deployment

This project uses [docker](https://docs.docker.com/) to package the application. The docker configuration in the **Dockerfile** file at the root of the folder.
The project is hosted on [Heroku](https://www.heroku.com)



## Release History

- 0.0.1
  - Work in progress
