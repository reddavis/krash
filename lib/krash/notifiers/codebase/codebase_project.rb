require 'krash/notifiers/codebase/ticket'

module Krash
  module Notifiers
    module Codebase
      # THIS CLASS IS RATHER HACKISH.... AND NEEDS SOME REFACTORING ;) 
      class CodebaseProject  
        include HTTParty
        base_uri 'http://railslove.codebasehq.com'
        headers 'Accept' => 'application/xml'
        headers 'Content-type' => 'application/xml'
  
        def initialize(options)
          @auth = {:username => options[:user], :password => options[:api_key]}
          @project = options[:project]
        end

        def create_ticket(args={})
          content = args.delete(:content)
    
          ticket = self.class.post url_for("/tickets"), :body => Ticket.new(args.merge(:kind => "ticket")).to_xml, :basic_auth => @auth
    
          add_note_to_ticket(ticket["ticket"]["ticket_id"], content) if content
        end
  
        def add_note_to_ticket(ticket_id, content)
          # TODO: codebase api seems to be strange here... they respond with an exception?! --- hack: just ignore it
          begin
            self.class.post url_for("/tickets/#{ticket_id}/notes"), :body => Ticket.new(:content => content, :kind => "ticket-note").to_xml, :basic_auth => @auth 
          rescue
          end
        end
  
        def tickets(args={})
          self.class.get(url_for("/tickets"), :query => args, :basic_auth => @auth)["tickets"]
        end
  
        protected
  
        def url_for(path)
          "/#{@project}#{path}"
        end
      end
      
    end
  end
end