# Rales Engine

This application is a Ruby on Rails "Sales Engine" JSON API using sanitized Etsy data. 

The project spec and information about the endpoints provided: 
[Rales Engine Project Spec](http://backend.turing.io/module3/projects/rails_engine#technical-expectations)

Visual representation of the databases available in this API:
[Schema](http://ondras.zarovi.cz/sql/demo/?keyword=rales-engine)

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installing](#installing)
- [Running the Tests](#running-the-tests)
- [Test Details](#tests-details)
- [Built With](#built-with)
- [Authors](#authors)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system

### Prerequisites

* ruby version 2.4+
* rails version 5+
* postgresql version 10+

### Installing

* clone down this repository and change into the directory
```
git clone https://github.com/annaroyer/rales_engine.git
```
* bundle
```
bundle
```
* create the database and run the database migrations
```
rake db:{create, migrate}
```
* seed the database by entering rake import_csv:load
```
rake import_csv:load
```
* start up rails server
```
rails s
```
* visit any of the API endpoints in your browser

## Running the tests

To run the test suite run rspec in your terminal:

```
rspec
```

## Tests Details

Our test suite includes controller tests for every endpoint in the spec/api/v1 directory and tests for every model in the spec/models directory.

### Tested With

* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - Used to generate stubbed active record objects
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) - Used to test model validations and relationships
* [DatabaseCleaner](https://github.com/DatabaseCleaner/database_cleaner)

## Built With

* [Rails](http://rubyonrails.org/) - The web framework used
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers/tree/0-10-stable) - Used to customize JSON

## Authors

* [Katy Welyczko](https://github.com/katyjane8)
* [Anna Royer](https://github.com/annaroyer)
