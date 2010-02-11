require "spec_helper"
require "krash/notifiers/codebase"

describe Krash::Notifiers::Codebase do
  
  before do
    @default_config = Krash::Configuration.new do
      api_key "key"
      priority_id 9
      status_id 3
      user 'captain_hook'
    end
    @notifier = Krash::Notifiers::Codebase.new(@default_config)
  end
  
  describe "Notification" do
    it "should create a ticket" do
      codebase_project = mock(:codebase_project)
      
      CodebaseProject.should_receive(:new).with(hash_including(
                                                                :user => @default_config.user,
                                                                :api_key => @default_config.api_key,
                                                                :project => exception[:application][:project]
                                                              )).and_return(codebase_project)
                                                              
      codebase_project.should_receive(:create_ticket).with(hash_including(
                                                                          :"priority-id" => @default_config.priority_id,
                                                                          :"status-id" => @default_config.status_id,
                                                                          :summary => exception[:exception][:message]
                                                                          ))
      
      @notifier.notify(exception)
    end
  end

end
