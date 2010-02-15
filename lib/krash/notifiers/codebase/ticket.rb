module Krash
  module Notifiers
    module Codebase
      
      class Ticket
        attr_accessor :kind, :attributes
  
        def initialize(attributes)
          self.kind = attributes.delete(:kind) || "ticket"
          self.attributes = attributes
        end
  
        def to_xml
          builder = Builder::XmlMarkup.new
          builder.tag!(self.kind) do |ticket|
            attributes.each do |key,value|
              ticket.tag!(key, value) unless value.nil?
            end
          end
        end
      end
      
    end
  end
end