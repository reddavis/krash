$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'krash'
require 'spec'
require 'spec/autorun'
require 'rack/test'

def exception(args={})
  {
    :exception => {:message => "123"},
    :application => {:project => 'test_project'}
  }.merge(args)
end

def exception_xml(api_key="76fdb93ab2cf276ec080671a8b3d3866")
  %{
    <?xml version="1.0" encoding="UTF-8"?>
    <notice version="2.0">
      <api-key>#{api_key}</api-key>
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

Spec::Runner.configure do |config|
  
end
