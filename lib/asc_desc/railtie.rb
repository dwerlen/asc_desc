module AscDesc
  class Railtie < Rails::Railtie
    initializer 'asc_desc.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
      # This is required to add <tt>method_missing</tt>.
      ActiveRecord::Relation.send(:include, ModelAdditions)
    end
  end
end