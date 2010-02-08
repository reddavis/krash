require "spec_helper"
require "krash/notifiers/iphone"

describe Krash::Notifiers::Iphone do
  
  before do
    @default_config = Krash::Configuration.new do
      api_keys "key"
      only /.*/
    end
    @notifier = Krash::Notifiers::Iphone.new(@default_config)
  end
  
  describe "Notification" do
    it "should not notify only if the exception message matches not a certain pattern"
    
    it "should notify if the exception message matches a certain pattern"
    
    it "should use prowl to send notifications"
    
    it "should send exception message as notification body"
    
  end

end
