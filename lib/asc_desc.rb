require 'asc_desc/version'
require 'asc_desc/model_additions'
require 'asc_desc/railtie' if defined? Rails

module AscDesc

  ASC  = 'ASC'
  DESC = 'DESC'

  def self.format_order_clause(*args)
    order = args.last
    args[0..-2].map do |column|
      if column.is_a?(Array)
        format_order_clause(*column << order)
      elsif column.respond_to?('include?') and column.include?(?,)
        format_order_clause(*column.split(?,) << order)
      else
        "#{column.to_s.strip} #{order}"
      end
    end.join(', ')
  end

end