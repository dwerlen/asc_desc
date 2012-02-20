# asc_desc [![Build Status](https://secure.travis-ci.org/dwerlen/asc_desc.png)](https://secure.travis-ci.org/dwerlen/asc_desc)

This gem adds two new methods to ActiveRecord (and ActiveRecord::Relation) that allows to sort SQL queries without using
the "ASC" and "DESC" SQL keywords.

## Remark

`asc_desc` was developed in order to experiment the creation of a ruby gem. 
It was conducted on the basis of the excellent tutorials from Ryan Bates, namely:

* ["#301 Extracting a Ruby Gem"](http://railscasts.com/episodes/301-extracting-a-ruby-gem)
* ["#303 Publishing a Gem"](http://railscasts.com/episodes/303-publishing-a-gem)


## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem 'asc_desc', git: 'git@github.com:dwerlen/asc_desc.git'
 ```


## requirements

* Ruby 1.8.7 or later
* Ruby on Rails 3.0 or later


## Usage

Call `asc` on an ActiveRecord object or on an ActiveRecord::Relation object to sort the column(s) in an ascending way.

 ```ruby
 # using a symbol for the name of the column
 Candy.where(:sugar => true).asc(:name)
 
 # using a string for the name of the column
 Candy.where(:sugar => true).asc('name')

 # using multiple parameters to specify more than one column for the sort clause
 Candy.where(:sugar => true).asc(:classification, :name)

 # using an array to pass mutliple argument
 Candy.where(:sugar => true).asc([:classification, :name])
 
 # using a string to specify more than one column for the sort clause
 Candy.where(:sugar => true).asc('classification, name')
 
 # the method is chainable
 Candy.where(:sugar => true).asc(:classification).asc(:name)
 ```

Call `desc` on an ActiveRecord object or on an ActiveRecord::Relation object to sort the column(s) in a descending way.

 ```ruby
 # using a symbol for the name of the column
 Candy.where(:sugar => true).desc(:name)
 
 # using a string for the name of the column
 Candy.where(:sugar => true).desc('name')
 
 # using multiple parameters to specify more than one column for the sort clause
 Candy.where(:sugar => true).desc(:classification, :name)
 
 # using an array to pass mutliple argument
 Candy.where(:sugar => true).desc([:classification, :name])
 
 # using a string to specify more than one column for the sort clause
 Candy.where(:sugar => true).desc('classification, name')
 
 # the method is chainable
 Candy.where(:sugar => true).desc(:classification).desc(:name)
 ```

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/dwerlen/asc_desc/issues).
You can contribute changes by forking the project and submitting a pull request.
You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by David Werlen and is under the MIT License.
