module Krash
  class HoptoadParser
    
    def initialize(data)
      @data = data
    end
    
    def application
      @application_settings ||= begin
        node = xml.xpath("/notice/api-key").text
        YAML.load(node) rescue {}
      end
    end
    
    def exception
      {
        :class => xml.xpath("/notice/error/class").text,
        :message => xml.xpath("/notice/error/message").text,
        :backtrace => xml.xpath("/notice/error/backtrace").to_s,
        :request => xml.xpath("/notice/request").to_s,
        :environment => xml.xpath("/notice/server-environment").to_s
      }
    end
    
    def memcached_key
      (exception[:backtrace] + exception[:class]).gsub(/\W+/, '_')
    end
        
    def xml
      @xml ||= Nokogiri::XML(@data)
    end
    
  end
end