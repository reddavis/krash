require File.dirname(__FILE__) + '/vendor/gems/environment'
Bundler.require_env

require "krash/configuration"
require "krash/app"

module Krash
  @config = Configuration.new
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