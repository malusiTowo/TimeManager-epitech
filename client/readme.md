# Web Client Time Management

## CI statuses

[![Heroku Deployment](https://github.com/malusiTowo/TimeManager-epitech/workflows/heroku-deployment/badge.svg)](https://github.com/malusiTowo/TimeManager-epitech/actions)

## Description

This project is the web client of the time management epitech project. This project is built with [Vue](https://vuejs.org/). This project is a time management system for employees, managers and adminstrators. You can enter working times for employees and they can clock-in and clock-out of work. All the data is then collected and presented in data graphs.


## Scripts

## Install

Run the following command to install all the dependencies of the project. All dependencies can be found in the **package.json** file.

```
$ npm install
```

## Tests

Run the following commands to run the test of the project. All the of the tests can be found in the **__tests\_\_** folder.

```
$ npm run test
```

## Development

Run the following command to run the development server.

```
$ npm run serve
```

## Deployment

This project uses [docker](https://docs.docker.com/) to package the application. The docker configuration in the **Dockerfile** file at the root of the folder.
The project is hosted on [Heroku](https://www.heroku.com)

## Environment variables

```
BACKEND_URL=""
```


## Authentication & Authorization

This project uses JWT mechanism to authenticate users and to validate incoming requests. Each user is assigned a role (admin, manager, employee), depending on the role, the user is authorized to perform certain actions

Each request to the server should have the following header

```
Authorization: Bearer {JWT token}
```

## Release History

- 0.0.1
  - Work in progress
