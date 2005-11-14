require File.dirname(__FILE__) + '/../test_helper'

class TicketTest < Test::Unit::TestCase
  fixtures :tickets

  def setup
    @ticket = Ticket.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Ticket,  @ticket
  end
end
