begin
  # Require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end
Bundler.require(:default)

require "krash/configuration"
require "krash/hoptoad_parser"
require "krash/app"
#require 'krash/notifiers/codebase'
#require 'krash/notifiers/iphone'
#require 'krash/notifiers/sms'

module Krash
  @config = Configuration.new { parser Krash::HoptoadParser }
  @notifiers = []
  
  def self.configure(&block)
    instance_eval(&block)
  end
  
  def self.use(notifier,&block)
    @notifiers << notifier.new(Configuration.new(&block))
  end
  
  def self.set(key, value)
    @config[key] = value
  end
  
  def self.config
    @config
  end
  
  def self.notify(args)
    @notifiers.each do |notifier|
      notifier.notify(args)
    end
  end
  
end