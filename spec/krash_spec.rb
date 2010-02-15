require "spec_helper"
require "krash"

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
    
    sms_mock.should_receive(:notify).twice.with(argument_hash)
    Krash.notify(argument_hash)
  end
  
  it "should initialize a new notifier" do
    sms_mock = mock('sms')
    Krash::Notifiers::Sms.should_receive(:new).and_return(sms_mock)
    
    Krash.use(Krash::Notifiers::Sms) do
      numbers 123
      user "user"
      password "passwd"
      api_key "key"
      only /.*/
    end
  end
  
  it "should set config options in a Configuration object" do
    Krash.config.should be_a(Krash::Configuration)
  end
  
  def argument_hash
    argument_hash = {:a => 'b'}
  end
end
