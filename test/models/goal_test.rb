require "test_helper"

class GoalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "goal title must not be empty" do
    goal = Goal.new
    assert goal.invalid?
    assert goal.errors[:title].any?
  end

  test "goal status should update" do
    goal = goals(:one)
    assert_equal "not_started", goal.status

    goal.status = goal.next_status
    assert_equal "in_process", goal.status

    goal.status = goal.next_status
    assert_equal "completed", goal.status

    goal.status = goal.next_status
    assert_equal "not_started", goal.status
  end
end
