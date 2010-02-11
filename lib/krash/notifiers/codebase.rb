require 'builder'
require 'krash/notifiers/codebase/codebase_project'

module Krash
  module Notifiers
    
    class Codebase
      attr_accessor :config
      
      def initialize(config)
        @config = config
      end
      
      def notify(args)
        content = ""
        args[:exception].each do |key,value|
          content << key.to_s
          content << "\n"
          content << "--------------"
          content << "\n\n"
          value.each do |line|
            content << "    #{line}"
          end
          content << "\n\n\n"
        end
        
        ticket = {
          :summary => args[:exception][:message ],
          :content => content,
          :"ticket-type" => "bug",
          :"priority-id" => @config.priority_id,
          :"status-id" => @config.status_id
        }
        
        CodebaseProject.new(:user => @config.user, :api_key => @config.api_key, :project => args[:application][:project]).create_ticket(ticket)
      end
    end
    
  end
end