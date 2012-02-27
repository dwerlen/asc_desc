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


    # alias of the built-in `order` method.
    #
    # Will be extended in future versions of the library.
    #
    def order_by(*args)
      self.order(*args)
    end

  end
end