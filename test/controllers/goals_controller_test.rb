require "test_helper"

class GoalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goal = goals(:one)
    @user = users(:one)
  end

  test "should get index" do
    sign_in_as(@user)
    get root_path
    assert_response :success
    assert_select "form"
  end

  test "should create goal" do
    sign_in_as(@user)
    assert_difference("@user.goals.count", 1) do
      post goals_path, params: { goal: { title: @goal.title } }
    end
    assert_redirected_to root_path
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_goal_url(@goal)
    assert_response :success
    assert_select "form"
  end

  test "should update goal" do
    sign_in_as(@user)
    patch goal_url(@goal), params: { goal: { title: "new title" } }
    assert_redirected_to root_path
  end

  test "should destroy goal" do
    sign_in_as(@user)
    assert_difference("@user.goals.count", -1) do
      delete goal_url(@goal)
    end

    assert_redirected_to root_path
  end

  private
  # Helper method to simulate an authenticated user
  def sign_in_as(user)
    post login_url, params: { name: user.name, password: "secret" }
    follow_redirect!
  end
end
