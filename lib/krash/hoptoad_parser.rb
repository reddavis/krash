module Krash
  class HoptoadParser
    
    def initialize(data)
      @data = data
    end
    
    # This isn't part of the hoptoad API anymore: http://help.hoptoadapp.com/faqs/api-2/api-overview
    def application
      @application_settings ||= begin
        node = xml.xpath("/notice/api-key").text
        YAML.load(node) rescue {}
      end
    end
    
    def exception
      {
        :class => xml.xpath("/group/error-class").text,
        :message => xml.xpath("/group/error-message").text,
        :backtrace => xml.xpath("/group/backtrace").text,
        :request => xml.xpath("/group/request").text,
        :environment => xml.xpath("/group/rails-env").text,
        :file => xml.xpath("/group/file").text,
        :controller => xml.xpath("/group/controller").text,
        :action => xml.xpath("/group/action").text
      }
    end
    
    def new?
      xml.xpath("/group/notices-count").text.to_i == 1 ? true : false
    end
    
    def xml
      @xml ||= Nokogiri::XML(@data)
    end
    
  end
end