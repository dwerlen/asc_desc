require 'active_record'
require 'with_model'
require 'asc_desc'

RSpec.configure do |config|
  config.extend ::WithModel
end

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')