module Krash
  class App < Sinatra::Base
    
    post "/notifier_api/v2/notices/" do
      
      body = Nokogiri::XML(request.body)
      application = YAML.load(body.xpath("/notice/api-key").first.content)
      
      halt(401, "go away!") if application[:access_key] != Krash.config.access_key.to_s
      
      exception = {
        :class => body.xpath("/notice/error/class").collect(&:content).join(","),
        :message => body.xpath("/notice/error/message").collect(&:content).join(","),
        :backtrace => body.xpath("/notice/error/backtrace").to_s,
        :request => body.xpath("/notice/request").to_s,
        :environemt => body.xpath("/notice/server-environment").to_s
      }
      
      # TODO: would be cool to do this asynchronous
      Krash.notify :application => application, :exception => exception, :raw => request.body
      
      # whatever happens we currently just say everything is great. ;)
      201
    end

  end

end