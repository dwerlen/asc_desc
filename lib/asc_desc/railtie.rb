module AscDesc
  class Railtie < Rails::Railtie
    initializer 'asc_desc.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end