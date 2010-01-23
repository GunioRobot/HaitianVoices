require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should be able to get a random story" do
    assert Story.all.include?(Story.random)
  end
end
