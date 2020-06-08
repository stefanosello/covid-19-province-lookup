# COVID 19 - PROVINCES LOOKUP

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/Mr5he11/covid-19-province-lookup/commits/master)
[![Website http://covid-19-province-lookup.herokuapp.com/](https://img.shields.io/website-up-down-green-red/http/shields.io.svg)](https://www.covid19-stats.it/)
[![Open Source Love svg1](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

This project was born because of the need of having a way to visualize data about Covid-19 pandemic in the italian provinces.
Since fresh daily data of new cases of covid-19 are available, thanks to Italian government, this website takes daily those data
and creates charts that help to get an idea of how the pandemic is going in each province, with the possibility to plot together more
datasets.

### System requirements
1. [Ruby 2.5.6](https://www.ruby-lang.org/en/)
2. [Rails 6.0.3](https://rubyonrails.org/)
3. [PostgreSQL 11 or higher](https://www.postgresql.org)

### How to set development environment
This project is written in RubyOnRails, Vue.js and PostgreSQL.
In order to make it work:
1. clone the repository
2. `bundle install` to install missing gems
3. `yarn install` to install js libraries
4. `rails db:create` to create db (make sure first that db settings in `config/database.yml` are properly setted)
5. `rails db:migrate` to populate database
6. `rails s` to start the development rails server
7. `bin/webpack-dev-server` in another terminal window (do not kill rails server!) to get a faster js compilation through webpack dev server

If you want to contribute with improvements, you are welcome to submit a pull request!
