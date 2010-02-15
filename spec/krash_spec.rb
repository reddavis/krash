require "spec_helper"
require "krash"
require "krash/notifiers/sms"

describe Krash do
  it "should call #notify on every registed notifier and pass the arguments hash" do
    sms_mock = mock('sms')
    Krash::Notifiers::Sms.stub!(:new).and_return(sms_mock)
    
    2.times do
      Krash.use(Krash::Notifiers::Sms) do
        numbers 123
        user "user"
        password "passwd"
        api_key "key"
        only /.*/
      end
    end
    
    argument_hash = {:a => 'b'}
    
    sms_mock.should_receive(:notify).twice.with(argument_hash)
    Krash.notify(argument_hash)
  end
  
  it "should initialize a new notifier and add it to the notifiers array"
  
  it "should set config options in a Configuration object"
end
