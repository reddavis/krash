require "spec_helper"
require "krash/hoptoad_parser"

describe Krash::HoptoadParser do
  describe "A new exception object" do
    before(:all) do
      @parser = Krash::HoptoadParser.new(old_exception_xml)
    end
    
    describe "Exception data" do
      it "should return correct class" do
        @parser.exception[:class].should == "ActionView::TemplateError"
      end
      
      it "should return correct message" do
        @parser.exception[:message].should == "ActionView::TemplateError: private method `gsub' called for nil:NilClass"
      end
      
      it "should return backtrace" do
        @parser.exception[:backtrace].should == 'Backtrace'
      end
      
      it "should return request" do
        @parser.exception[:request].should == "Request"
      end
      
      it "should return environment" do
        @parser.exception[:environment].should == "production"
      end
      
      it "should return file" do
        @parser.exception[:file].should == "On line #6 of stories/_content.html.erb"
      end
      
      it "should return controller" do
        @parser.exception[:controller].should == "magic"
      end
      
      it "should return action" do
        @parser.exception[:action].should == "index"
      end
    end
  end
  
  describe "Receiving a new exception" do
    before(:all) do
      @parser = Krash::HoptoadParser.new(new_exception_xml)
    end
    
    it "should notice its a new error" do
      @parser.new_error?.should be_true
    end
  end
  
  describe "Receiving an old exception" do
    before(:all) do
      @parser = Krash::HoptoadParser.new(old_exception_xml)
    end
    
    it "should notice its an old error" do
      @parser.new_error?.should be_false
    end
  end
  
  private
  
  def new_exception_xml
    %{<group> 
      <action>index</action> 
      <controller>magic</controller> 
      <created-at type="datetime">2009-01-27T11:36:27Z</created-at> 
      <error-class>Mysql::Error</error-class> 
      <error-message>Mysql::Error: Lost connection to MySQL server during query</error-message> 
      <file>[GEM_ROOT]/gems/activerecord-2.1.0/lib/active_record/vendor/mysql.rb</file> 
      <id type="integer">212912</id> 
      <lighthouse-ticket-id type="integer" nil="true"></lighthouse-ticket-id> 
      <line-number type="integer">1107</line-number> 
      <most-recent-notice-at type="datetime">2009-01-27T11:36:26Z</most-recent-notice-at> 
      <notice-hash>sssssaacssssss</notice-hash> 
      <notices-count type="integer">1</notices-count> 
      <project-id type="integer">1973</project-id> 
      <rails-env>production</rails-env> 
      <resolved type="boolean">false</resolved> 
      <updated-at type="datetime">2009-03-24T21:26:56Z</updated-at> 
      <environment></environment> 
      <session></session> 
      <request></request> 
      <backtrace></backtrace> 
    </group>
    }
  end
  
  def old_exception_xml
    %{
      <group> 
        <action>index</action> 
        <controller>magic</controller> 
        <created-at type="datetime">2009-01-16T02:34:11Z</created-at> 
        <error-class>ActionView::TemplateError</error-class> 
        <error-message>ActionView::TemplateError: private method `gsub' called for nil:NilClass</error-message> 
        <file>On line #6 of stories/_content.html.erb</file> 
        <id type="integer">185188</id> 
        <lighthouse-ticket-id type="integer" nil="true"></lighthouse-ticket-id> 
        <line-number type="integer" nil="true"></line-number> 
        <most-recent-notice-at type="datetime">2009-01-16T19:55:35Z</most-recent-notice-at> 
        <notice-hash>307636c397776468278bc93b64717352</notice-hash> 
        <notices-count type="integer">151</notices-count> 
        <project-id type="integer">1973</project-id> 
        <rails-env>production</rails-env> 
        <resolved type="boolean">false</resolved> 
        <updated-at type="datetime">2009-03-24T21:02:46Z</updated-at> 
        <environment></environment> 
        <session></session> 
        <request>Request</request> 
        <backtrace>Backtrace</backtrace> 
      </group>
    }
  end
end