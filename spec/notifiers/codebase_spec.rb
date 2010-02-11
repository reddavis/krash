require "spec_helper"
require "krash/notifiers/codebase"

describe Krash::Notifiers::Codebase do
  
  before do
    @default_config = Krash::Configuration.new do
      api_keys "key"
      only /.*/
    end
    @notifier = Krash::Notifiers::Iphone.new(@default_config)
  end
  
  #describe "Notification" do
  #  it "should not notify if the exception matches does not match the pattern" do
  #    Prowl.should_not_receive(:add)
  #    @notifier.config.only = /\d/  # Set the pattern to match
  #    @notifier.notify(:exception => {:message => "not number"} ).should == false
  #  end
  #  
  #  it "should notify if the exception message matches a certain pattern" do
  #    @notifier.config.only = /\d/
  #    
  #    Prowl.should_receive(:add).with(hash_including({
  #                                                    :event => "Exception in #{exception[:application][:project]}",
  #                                                    :application => 'Krash!',
  #                                                    :apikey => @default_config.api_keys,
  #                                                    :description => exception[:exception][:message]
  #                                                  }))
  #    
  #    @notifier.notify(exception)
  #  end
  #end

end
