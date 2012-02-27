module AscDesc
  module ModelAdditions

    # Call <tt>asc</tt> on an ActiveRecord object or on an ActiveRecord::Relation object to sort
    # the column(s) in an ascending way.
    #
    # using a symbol for the name of the column
    #   Candy.where(:sugar => true).asc(:name)
    #
    # using a string for the name of the column
    #   Candy.where(:sugar => true).asc('name')
    #
    # using multiple parameters to specify more than one column for the sort clause
    #   Candy.where(:sugar => true).asc(:classification, :name)
    #
    # using an array to pass mutliple argument
    #   Candy.where(:sugar => true).asc([:classification, :name])
    #
    # using a string to specify more than one column for the sort clause
    #   Candy.where(:sugar => true).asc('classification, name')
    #
    # without argument, the method generates a sort by id (custom primary key supported)
    #   SELECT "candies".* FROM "candies" ORDER BY id ASC
    #   Candy.where(:sugar => true).asc
    #
    # the method is chainable
    #   Candy.where(:sugar => true).asc(:classification).asc(:name)
    #
    def asc(*args)
      self.order AscDesc.format_order_clause(*(args.presence || [self.primary_key]) << AscDesc::ASC)
    end
    alias :ascending :asc
    alias :ascending_order :asc


    # Call <tt>desc</tt> on an ActiveRecord object or on an ActiveRecord::Relation object to sort
    # the column(s) in a descending way.
    #
    # using a symbol for the name of the column
    #   Candy.where(:sugar => true).desc(:name)
    #
    # using a string for the name of the column
    #   Candy.where(:sugar => true).desc('name')
    #
    # using multiple parameters to specify more than one column for the sort clause
    #   Candy.where(:sugar => true).desc(:classification, :name)
    #
    # using an array to pass mutliple argument
    #   Candy.where(:sugar => true).desc([:classification, :name])
    #
    # using a string to specify more than one column for the sort clause
    #   Candy.where(:sugar => true).desc('classification, name')
    #
    # without argument, the method generates a sort by id (custom primary key supported)
    #   SELECT "candies".* FROM "candies" ORDER BY id DESC
    #   Candy.where(:sugar => true).desc
    #
    # the method is chainable
    #   Candy.where(:sugar => true).desc(:classification).desc(:name)
    #
    def desc(*args)
      self.order AscDesc.format_order_clause(*(args.presence || [self.primary_key]) << AscDesc::DESC)
    end
    alias :descending :desc
    alias :descending_order :desc


    # a call to <tt>order_by</tt> just acts like the standard built-in "order" method (alias)
    #   Candy.where(:sugar => true).order_by('classification ASC, name ASC')
    #
    def order_by(*args)
      self.order(*args)
    end


private

    # The **dynamic order_by mechanism** is built the same way as the dynamic finders present from the beginning of
    # Ruby On Rails and allows to easely write the order clause for ActiveRecord queries.
    #
    # using a column as part of the method name
    #   Candy.where(:sugar => true).order_by_name
    #
    # using a column and a sort direction (asc|desc) as part of the method name
    #   Candy.where(:sugar => true).order_by_name_asc
    #   Candy.where(:sugar => true).order_by_name_desc
    #
    # using multiple columns as part of the method name
    #   Candy.where(:sugar => true).order_by_classification_and_name
    #   Candy.where(:sugar => true).order_by_classification_and_name_and_sugar
    #
    # using multiple columns and sort directions (asc|desc) as part of the method name
    #   Candy.where(:sugar => true).order_by_classification_asc_and_name_desc
    #   Candy.where(:sugar => true).order_by_classification_desc_and_name_asc
    #   Candy.where(:sugar => true).order_by_classification_asc_and_name_desc_and_sugar_asc
    #
    # using multiple columns with or without sort direction (asc|desc) as part of the method name
    #   Candy.where(:sugar => true).order_by_classification_and_name_desc
    #   Candy.where(:sugar => true).order_by_classification_desc_and_name
    #
    def method_missing(method_sym, *arguments, &block)
      # the first argument is a Symbol, so we need to_s it if you want to match the pattern
      if method_sym.to_s =~ /^order_by_([_a-zA-Z]\w*)$/
        columns = $1.split('_and_').map do |column|
          if column.ends_with?('_asc')
            "#{column[0..-5]} ASC"
          elsif column.ends_with?('_desc')
            "#{column[0..-6]} DESC"
          else
            "#{column} ASC" # always use explicit sort direction
          end
        end
        self.order(columns)
      else
        super
      end
    end

  end
end