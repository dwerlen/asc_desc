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

  with_model :Bonbon do
    # The table block works just like a migration.
    table :primary_key => :id_bonbon do |t|
      t.string  :name
      t.string  :classification
      t.boolean :sugar
      t.timestamps
    end
    # The model block works just like the class definition.
    model do
      extend AscDesc::ModelAdditions
      self.primary_key = :id_bonbon
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

  it 'respond to a class method named "order_by"' do
    Candy.respond_to?(:order_by).should be_true
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

    it 'can format an array as mutliple arguments' do
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

    it 'generates a sort by id when no argument is passed' do
      candies = Candy.asc
      candies.to_sql.should be_end_with('ORDER BY id ASC')
    end

    it 'generates a sort by id when no argument is passed even with a custom primary key' do
      bonbons = Bonbon.asc
      bonbons.to_sql.should be_end_with('ORDER BY id_bonbon ASC')
    end

    it 'should be chainable' do
      candies = Candy.asc(:name)
      candies = candies.asc
      candies = candies.asc(:sugar)
      candies.should be_an_instance_of(ActiveRecord::Relation)
      candies.to_sql.should be_end_with('ORDER BY name ASC, id ASC, sugar ASC')
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

    it 'can format an array as mutliple arguments' do
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

    it 'generates a sort by id when no argument is passed' do
      candies = Candy.desc
      candies.to_sql.should be_end_with('ORDER BY id DESC')
    end

    it 'generates a sort by id when no argument is passed even with a custom primary key' do
      bonbons = Bonbon.desc
      bonbons.to_sql.should be_end_with('ORDER BY id_bonbon DESC')
    end

    it 'should be chainable' do
      candies = Candy.desc(:name)
      candies = candies.desc
      candies = candies.desc(:sugar)
      candies.should be_an_instance_of(ActiveRecord::Relation)
      candies.to_sql.should be_end_with('ORDER BY name DESC, id DESC, sugar DESC')
    end

  end

  describe '.order_by' do

    it 'should return an ActiveRecord Relation' do
      candies = Candy.order_by(:name)
      candies.should be_an_instance_of(ActiveRecord::Relation)
    end

    it 'should define the "ORDER BY" clause of the underlying SQL query' do
      candies = Candy.order_by('classification ASC, name DESC')
      candies.to_sql.should be_end_with('ORDER BY classification ASC, name DESC')
    end

    it 'should accept multiple parameters' do
      candies = Candy.order_by('classification DESC', 'name ASC')
      candies.to_sql.should be_end_with('ORDER BY classification DESC, name ASC')
    end

  end

end