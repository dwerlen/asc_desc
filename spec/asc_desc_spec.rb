require 'spec_helper'

describe AscDesc do

  it 'has a constant for the ASC SQL keyword' do
    AscDesc.const_defined?(:ASC).should be_true
    AscDesc.const_get(:ASC).should eq('ASC')
  end

  it 'has a constant for the DESC SQL keyword' do
    AscDesc.const_defined?(:DESC).should be_true
    AscDesc.const_get(:DESC).should eq('DESC')
  end

  describe '.format_order_clause' do

    it 'respond to a class method named "format_order_clause"' do
      AscDesc.respond_to?(:format_order_clause)
    end

    it 'can format a symbol for the name of the column' do
      AscDesc.format_order_clause(:name, AscDesc::ASC).should eq('name ASC')
      AscDesc.format_order_clause(:name, AscDesc::DESC).should eq('name DESC')
    end

    it 'can format a string for the name of the column' do
      AscDesc.format_order_clause('name', AscDesc::ASC).should eq('name ASC')
      AscDesc.format_order_clause('name', AscDesc::DESC).should eq('name DESC')
    end

    it 'can format multiple parameters to specify more than one column for the sort clause' do
      AscDesc.format_order_clause(:classification, :name, AscDesc::ASC).should eq('classification ASC, name ASC')
      AscDesc.format_order_clause(:classification, :name, AscDesc::DESC).should eq('classification DESC, name DESC')
      AscDesc.format_order_clause('classification', 'name', AscDesc::ASC).should eq('classification ASC, name ASC')
      AscDesc.format_order_clause('classification', 'name', AscDesc::DESC).should eq('classification DESC, name DESC')
    end

    it 'can format an array as mutliple argument' do
      AscDesc.format_order_clause([:classification, :name], AscDesc::ASC).should eq('classification ASC, name ASC')
      AscDesc.format_order_clause([:classification, :name], AscDesc::DESC).should eq('classification DESC, name DESC')
      AscDesc.format_order_clause([:classification, :name], :sugar, AscDesc::DESC).should eq('classification DESC, name DESC, sugar DESC')
      AscDesc.format_order_clause(['classification', 'name'], AscDesc::ASC).should  eq('classification ASC, name ASC')
      AscDesc.format_order_clause(['classification', 'name'], AscDesc::DESC).should eq('classification DESC, name DESC')
      AscDesc.format_order_clause(['classification', 'name'], 'sugar', AscDesc::DESC).should eq('classification DESC, name DESC, sugar DESC')
    end

    it 'can formata string to specify more than one column for the sort clause' do
      AscDesc.format_order_clause('classification, name', :sugar, AscDesc::ASC).should eq('classification ASC, name ASC, sugar ASC')
      AscDesc.format_order_clause(['classification, name', :sugar], AscDesc::ASC).should eq('classification ASC, name ASC, sugar ASC')
    end

  end

end