module Krash
  module Notifiers
    
    class Iphone
      attr_accessor :config
      
      def initialize(config)
        @config = config
      end
      
      def notify(args)
        return false unless args[:exception][:message] =~ @config.only
        [config.api_keys].flatten.each do |key|
          Prowl.add(:apikey => key,
                    :application => "Krash!",
                    :event => "Exception in #{args[:application][:project]}",
                    :description => args[:exception][:message]
                  )
        end
      end
      
      def prowl_config
        {
          :apikey => config.api_key,
          :application => "Krash!"
        }
      end
    end
  end
end