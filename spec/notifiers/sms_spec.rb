require "spec_helper"
require "krash/notifiers/sms"

describe Krash::Notifiers::Sms do
  
  before do
    @default_config = Krash::Configuration.new do
      numbers 123
      user "user"
      password "passwd"
      api_key "key"
      only /.*/
    end
    @notifier = Krash::Notifiers::Sms.new(@default_config)
  end
  
  describe "Notification" do
    it "should not notify if the exception matches does not match the pattern" do
      @notifier.should_not_receive(:clickatell)
      @notifier.config.only = /\d/  # Set the pattern to match
      @notifier.notify(:exception => {:message => "not number"} ).should == false
    end
    
    it "should notify if the exception message matches a certain pattern" do
      clickatell = mock(:clickatell)
      exception_message = exception
      @notifier.config.only = /\d/
    
      @notifier.should_receive(:clickatell).and_return(clickatell)
      clickatell.should_receive(:send).with(@default_config.numbers, "test_project: 123")
      
      @notifier.notify(exception)
    end    
  end

end
