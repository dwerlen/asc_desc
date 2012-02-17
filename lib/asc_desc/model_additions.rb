module AscDesc
  module ModelAdditions

    def asc(*args)
      self.order AscDesc.format_order_clause(*args, AscDesc::ASC)
    end
    alias :ascending :asc
    alias :ascending_order :asc

    def desc(*args)
      self.order AscDesc.format_order_clause(*args, AscDesc::DESC)
    end
    alias :descending :desc
    alias :descending_order :desc

  end
end