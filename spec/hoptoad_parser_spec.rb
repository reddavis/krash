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
end