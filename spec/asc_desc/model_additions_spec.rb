require 'spec_helper'

describe AscDesc::ModelAdditions do

  with_model :Candy do
    # The table block works just like a migration.
    table do |t|
      t.string  :name
      t.string  :classification
      t.boolean :sugar
      t.timestamps
    end
    # The model block works just like the class definition.
    model do
      extend AscDesc::ModelAdditions
    end
  end

  it 'respond to a class method named "asc"' do
    Candy.respond_to?(:asc).should be_true
    Candy.respond_to?(:ascending).should be_true
    Candy.respond_to?(:ascending_order).should be_true
  end

  it 'respond to a class method named "desc"' do
    Candy.respond_to?(:desc).should be_true
    Candy.respond_to?(:descending).should be_true
    Candy.respond_to?(:descending_order).should be_true
  end

  describe '.asc' do

    it 'should return an ActiveRecord Relation' do
      candies = Candy.asc(:name)
      candies.should be_an_instance_of(ActiveRecord::Relation)
    end

    it 'can format a symbol for the name of the column' do
      candies = Candy.asc(:name)
      candies.to_sql.should be_end_with('ORDER BY name ASC')
    end

    it 'can format a string for the name of the column' do
      candies = Candy.asc('name')
      candies.to_sql.should be_end_with('ORDER BY name ASC')
    end

    it 'can format multiple parameters to specify more than one column for the sort clause' do
      candies = Candy.asc(:classification, :name)
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC')

      candies = Candy.asc('classification', 'name')
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC')
    end

    it 'can format an array as mutliple argument' do
      candies = Candy.asc([:classification, :name])
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC')
      candies = Candy.asc([:classification, :name], :sugar)
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC, sugar ASC')

      candies = Candy.asc(['classification', 'name'])
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC')
      candies = Candy.asc(['classification', 'name'], 'sugar')
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC, sugar ASC')
    end

    it 'can format a string to specify more than one column for the sort clause' do
      candies = Candy.asc('classification, name', :sugar)
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC, sugar ASC')

      candies = Candy.asc(['classification, name', :sugar])
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name ASC, sugar ASC')
    end

    it 'should be chainable' do
      candies = Candy.asc(:name)
      candies = candies.asc(:sugar)
      candies.should be_an_instance_of(ActiveRecord::Relation)
      candies.to_sql.should be_end_with('ORDER BY name ASC, sugar ASC')
    end

  end

  describe '.desc' do

    it 'should return an ActiveRecord Relation' do
      candies = Candy.desc(:name)
      candies.should be_an_instance_of(ActiveRecord::Relation)
    end

    it 'can format a symbol for the name of the column' do
      candies = Candy.desc(:name)
      candies.to_sql.should be_end_with('ORDER BY name DESC')
    end

    it 'can format a string for the name of the column' do
      candies = Candy.desc('name')
      candies.to_sql.should be_end_with('ORDER BY name DESC')
    end

    it 'can format multiple parameters to specify more than one column for the sort clause' do
      candies = Candy.desc(:classification, :name)
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC')

      candies = Candy.desc('classification', 'name')
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC')
    end

    it 'can format an array as mutliple argument' do
      candies = Candy.desc([:classification, :name])
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC')
      candies = Candy.desc([:classification, :name], :sugar)
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC, sugar DESC')

      candies = Candy.desc(['classification', 'name'])
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC')
      candies = Candy.desc(['classification', 'name'], 'sugar')
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC, sugar DESC')
    end

    it 'can format a string to specify more than one column for the sort clause' do
      candies = Candy.desc('classification, name', :sugar)
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC, sugar DESC')

      candies = Candy.desc(['classification, name', :sugar])
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name DESC, sugar DESC')
    end

    it 'should be chainable' do
      candies = Candy.desc(:name)
      candies = candies.desc(:sugar)
      candies.should be_an_instance_of(ActiveRecord::Relation)
      candies.to_sql.should be_end_with('ORDER BY name DESC, sugar DESC')
    end

  end

end