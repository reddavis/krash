require 'rubygems'
require 'clickatell'

module Krash
  module Notifiers
    
    class Sms
      attr_accessor :config
      
      def initialize(config)
        @config = config
      end
      
      def notify(args)
        return false unless args[:exception][:message] =~ @config.only
        
        [@config.numbers].flatten.each do |number|
          clickatell.send(number, "#{args[:application][:project]}: #{args[:exception][:message]}")
        end
      end
      
      def clickatell
        Clickatell::Text.new(@config.user, @config.password, @config.api_key)
      end
    end
  end
end