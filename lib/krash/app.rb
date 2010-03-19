require 'krash/extensions/run_later'
require 'krash/exception_store/hoptoad_exception'

module Krash
  class App < Sinatra::Base
    
    post "/notifier_api/v2/notices*" do
      exception = Krash.config.parser.new(request.body)
      
      halt(401, "go away!") unless exception.application.to_s == Krash.config.access_key.to_s
      
      unless HoptoadException.find_or_create_exception(exception)
        run_later do
          Krash.notify :application => exception.application, :exception => exception.exception, :raw => request.body
        end
      end
      
      # whatever happens we currently just say everything is great. ;)
      "Notification forwarded"
    end
    
    get "/notices_api/v1/notices/exist*" do
      "sorry, this is not yet implemented"
    end
  end  
end