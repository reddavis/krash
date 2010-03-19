require "spec_helper"
require "krash"
require "krash/app"
require "krash/notifiers/codebase"

describe Krash::App do
  include Rack::Test::Methods
  
  describe "Wrong API key" do
    it "should return 401" do
      post "/notifier_api/v2/notices", exception_xml
 
      last_response.status.should == 401
    end
  end
  
  describe "Good Request" do
    before { RunLater.run_now = true }
    
    ## Receive Mock "memcached" received unexpected message :get ???
    #describe "Exception does not already exist" do
    #  it "should call Krash.notify and save exception" do
    #    memcached = mock('memcached')
    #    Memcached.stub!(:new).and_return(memcached)
    #    memcached.stub!(:get).and_return(false)
    #    memcached.should_receive(:set)
    #    Krash.should_receive(:notify)
    #
    #    post "/notifier_api/v2/notices", exception_xml('1111')
    #    last_response.status.should == 200
    #  end
    #end
    
    describe "Exception already exists" do
      it "should not call Krash.notify" do
        memcached = mock('memcached2')
        Memcached.stub!(:new).and_return(memcached)
        memcached.stub!(:get).and_return(true)
        Krash.should_not_receive(:notify)
      
        post "/notifier_api/v2/notices", exception_xml('1111')
        last_response.status.should == 200
      end
    end
  end

  private
    
  def app
    Krash.configure do
      set :access_key, "1111"
      set :memcached_server, "localhost:11211"
      
      use Krash::Notifiers::Codebase::Base do 
        priority_id 20658
        status_id 28658
        user "user"
        api_key "key"
      end
    end
    
    Krash::App
  end
end
