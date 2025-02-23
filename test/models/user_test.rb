require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "user name should be unique" do
    user = users(:one)
    new_user = User.new(name: user.name)
    assert new_user.invalid?
    assert new_user.errors[:name].include?("has already been taken")
  end
end
