# asc_desc

This gem adds to new methods to ActiveRecord and ActiveRelation that allows to sort SQL queries without using the "ASC" and "DESC" SQL keywords.

## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem 'asc_desc'
 ```

**Requires Ruby 1.8.7 or later.**


## Usage

Call `asc` on an ActiveRecord object or on an ActiveRelation object to sort the column(s) in an ascending way.

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
 ```

Call `desc` on an ActiveRecord object or on an ActiveRelation object to sort the column(s) in an descending way.

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
 ```

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/dwerlen/asc_desc/issues).
You can contribute changes by forking the project and submitting a pull request.
You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by David Werlen and is under the MIT License.
