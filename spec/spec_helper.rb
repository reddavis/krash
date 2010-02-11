$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'krash'
require 'spec'
require 'spec/autorun'

def exception(args={})
  {
    :exception => {:message => "123"},
    :application => {:project => 'test_project'}
  }.merge(args)
end

Spec::Runner.configure do |config|
  
end
