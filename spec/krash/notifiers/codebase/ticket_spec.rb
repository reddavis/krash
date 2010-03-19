require "spec_helper"
require "krash/notifiers/codebase/ticket"

describe Krash::Notifiers::Codebase::Ticket do
  
  it "should set 'kind' to ticket by default" do
    a = build_ticket
    a.kind.should == 'ticket'
  end
  
  def build_ticket(options={})
    Krash::Notifiers::Codebase::Ticket.new(exception)
  end
end
