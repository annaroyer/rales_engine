# Rales Engine

This application is a Ruby on Rails "Sales Engine" JSON API using sanitized Etsy data. 

Visual representation of the databases available in this API:
[Schema](http://ondras.zarovi.cz/sql/demo/?keyword=rales-engine)

### Table of Contents
[Getting Started](#GettingStarted)

[Prerequisites](#Prerequisites)

[Installing](#Installing)

[Running the Tests](#RunningtheTests)

[Tests Information](#TestsInformation

[Built With](#BuiltWith)

[Authors](#Authors)

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
* seed the database
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

## Tests Information


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
