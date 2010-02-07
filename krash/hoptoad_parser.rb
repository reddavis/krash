module Krash
  class HoptoadParser
    
    def initialize(data)
      @data = data
    end
    
    def application
      @application_settings ||= begin
        node = xml.xpath("/notice/api-key").first.content
        YAML.load(node) rescue {:access_key => node}
      end
    end
    
    def exception
      {
        :class => xml.xpath("/notice/error/class").collect(&:content).join(","),
        :message => xml.xpath("/notice/error/message").collect(&:content).join(","),
        :backtrace => xml.xpath("/notice/error/backtrace").to_s,
        :request => xml.xpath("/notice/request").to_s,
        :environemt => xml.xpath("/notice/server-environment").to_s
      }
    end
    
    def xml
      @xml ||= Nokogiri::XML(@data)
    end
    
  end
end