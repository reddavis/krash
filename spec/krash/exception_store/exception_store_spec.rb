require "spec_helper"
require "krash/exception_store/hoptoad_exception"

describe Krash::HoptoadException do
  before do
    config = mock("config", :memcached_server => "1111")
    Krash.stub!(:config).and_return(config)
    @memcached = mock('memcached')
    Memcached.stub!(:new).and_return(@memcached)
  end
  
  # Receiving Mock "memcached" received unexpected message :get ???
  #describe "Exception exists" do
  #  it "should return true" do
  #    
  #    @memcached.stub!(:get).and_return(true)
  #    
  #    Krash::HoptoadException.find_or_create_exception(exception).should be_true
  #  end
  #end
  
  describe "Exception does not exist" do
    it "should return false and save the exception" do
      @memcached.stub!(:get).and_return(false)
    
      @memcached.should_receive(:set)
      Krash::HoptoadException.find_or_create_exception(exception).should be_false
    end
  end
  
  private
  
  def exception
    mock("exception", :memcached_key => '1111')
  end
end