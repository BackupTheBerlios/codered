require File.dirname(__FILE__) + '/../test_helper'

class ReportTest < Test::Unit::TestCase
  fixtures :reports

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Report, reports(:first)
  end
end
