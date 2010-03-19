module Krash
  
  class HoptoadException
    class << self
      # Returns true if it finds one
      def find_or_create_exception(exception)
        @key = exception.memcached_key

        if exception_exists?
          true
        else
          memcached.set(@key, true, three_weeks_in_seconds)
          false
        end
      end
          
      private
    
      def exception_exists?
        begin
          memcached.get(@key)
        rescue Memcached::NotFound
          false
        end
      end
    
      def memcached
        @memcached ||= Memcached.new(memcached_server)
      end
    
      def memcached_server
        Krash.config.memcached_server || raise("You need to set :memcached_server in Krash.config")
      end
    
      def three_weeks_in_seconds
        1814400
      end
    end
  end
  
end