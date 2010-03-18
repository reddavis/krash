require "spec_helper"
require "krash/hoptoad_parser"

describe Krash::HoptoadParser do
  describe "A new exception object" do
    before(:all) do
      @parser = Krash::HoptoadParser.new(exception_xml)
    end
    
    describe "Exception data" do
      it "should return the api_key" do
        @parser.application.should == "76fdb93ab2cf276ec080671a8b3d3866"
      end
      
      it "should return class" do
        @parser.exception[:class].should == "RuntimeError"
      end
      
      it "should return message" do
        @parser.exception[:message].should == "RuntimeError: I've made a huge mistake"
      end
      
      it "should return backtrace" do
        @parser.exception[:backtrace].should match(/models\/user.rb/)
      end
      
      it "should return request" do
        @parser.exception[:request].should match(/Mozilla/)
      end
      
      it "should return environment" do
        @parser.exception[:environment].should match(/production/)
      end
    end
  end
  
  private
  
  def exception_xml
    %{
      <?xml version="1.0" encoding="UTF-8"?>
      <notice version="2.0">
        <api-key>76fdb93ab2cf276ec080671a8b3d3866</api-key>
        <notifier>
          <name>Hoptoad Notifier</name>
          <version>1.2.4</version>
          <url>http://hoptoadapp.com</url>
        </notifier>
        <error>
          <class>RuntimeError</class>
          <message>RuntimeError: I've made a huge mistake</message>
          <backtrace>
            <line method="public" file="/testapp/app/models/user.rb" number="53"/>
            <line method="index" file="/testapp/app/controllers/users_controller.rb" number="14"/>
          </backtrace>
        </error>
        <request>
          <url>http://example.com</url>
          <component/>
          <action/>
          <cgi-data>
            <var key="SERVER_NAME">example.org</var>
            <var key="HTTP_USER_AGENT">Mozilla</var>
          </cgi-data>
        </request>
        <server-environment>
          <project-root>/testapp</project-root>
          <environment-name>production</environment-name>
        </server-environment>
      </notice>
    }
  end
end