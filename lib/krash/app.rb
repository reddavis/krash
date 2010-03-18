require 'krash/extensions/run_later'

module Krash
  class App < Sinatra::Base
    
    post "/notifier_api/v2/notices*" do
      
      parser = Krash.config.parser.new(request.body)
            
      halt(401, "go away!") unless parser.application[:access_key] == Krash.config.access_key.to_s
      
      run_later do
        Krash.notify :application => parser.application, :exception => parser.exception, :raw => request.body
      end
      
      # whatever happens we currently just say everything is great. ;)
      "Notification forwarded"
    end
    
    get "/notices_api/v1/notices/exist*" do
      "sorry, this is not yet implemented"
    end
    
  end
end