require File.dirname(__FILE__) + '/../test_helper'

class TicketTest < Test::Unit::TestCase
  fixtures :tickets

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Ticket, tickets(:first)
  end
end
