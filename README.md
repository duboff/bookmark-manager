Bookmark Manager
================

[![Code Climate](https://codeclimate.com/github/duboff/bookmark-manager.png)](https://codeclimate.com/github/duboff/bookmark-manager)

## Week 6 Project @ Makers Academy

The goal of this project was to build a simple bookmark management app where users can add their favourite links, select tags for them and add links to favourites.

In addition I have created a home-made authentication system using bcrypt similar to Devise. While normally one would just use Devise or a similar solution, this was a very valuable lesson in security and using controllers correctly. Password reminder function works on Heroku and uses Mandrill API for sending emails.

## Stack
* Ruby
* Sinatra
* PostgreSQL & DataMapper
* Rspec & Capybara
* HTML & CSS
* ERB
* Heroku deployment ([link](http://bookmark-manager-duboff.herokuapp.com/))
* Mandrill API
* bcrypt
* Shotgun

## Usage
From the console:

```
$ shotgun 
```

Or use online on Heroku [here](http://bookmark-manager-duboff.herokuapp.com/).

Please note, password reminder will only work on Heroku.

## Screenshot

![Screenshot](/bookmark-manager.png "Sudoku Web Version")


