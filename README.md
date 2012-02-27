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
 gem 'asc_desc'
 ```


## Requirements

* Ruby 1.8.7 or later
* Ruby on Rails 3.0 or later


## Usage

### asc

Call `asc` on an ActiveRecord object or on an ActiveRecord::Relation object to sort the column(s) in an ascending way.

 ```ruby
 # using a symbol for the name of the column
 Candy.where(:sugar => true).asc(:name)
 
 # using a string for the name of the column
 Candy.where(:sugar => true).asc('name')

 # using multiple parameters to specify more than one column for the sort clause
 Candy.where(:sugar => true).asc(:classification, :name)

 # using an array to pass mutliple arguments
 Candy.where(:sugar => true).asc([:classification, :name])
 
 # using a string to specify more than one column for the sort clause
 Candy.where(:sugar => true).asc('classification, name')
 
 # without argument, the method generates a sort by id (custom primary key supported)
 # SELECT "candies".* FROM "candies" ORDER BY id ASC
 Candy.where(:sugar => true).asc
 
 # the method is chainable
 Candy.where(:sugar => true).asc(:classification).asc(:name)
 ```

`ascending` and `ascending_order` are aliases of `asc`.


### desc

Call `desc` on an ActiveRecord object or on an ActiveRecord::Relation object to sort the column(s) in a descending way.

 ```ruby
 # using a symbol for the name of the column
 Candy.where(:sugar => true).desc(:name)
 
 # using a string for the name of the column
 Candy.where(:sugar => true).desc('name')
 
 # using multiple parameters to specify more than one column for the sort clause
 Candy.where(:sugar => true).desc(:classification, :name)
 
 # using an array to pass mutliple arguments
 Candy.where(:sugar => true).desc([:classification, :name])
 
 # using a string to specify more than one column for the sort clause
 Candy.where(:sugar => true).desc('classification, name')
 
 # without argument, the method generates a sort by id (custom primary key supported)
 # SELECT "candies".* FROM "candies" ORDER BY id DESC
 Candy.where(:sugar => true).desc
 
 # the method is chainable
 Candy.where(:sugar => true).desc(:classification).desc(:name)
 ```

`descending` and `descending_order` are aliases of `desc`.


### order_by

The current version of this gem introduces a new method called `order_by`. At this time, it's just an alias of the
built-in `order` method but will be extended in future versions of the library.


## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/dwerlen/asc_desc/issues).
You can contribute changes by forking the project and submitting a pull request.
You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by David Werlen and is under the MIT License.
