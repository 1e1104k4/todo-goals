require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

  test "should get new for unauthenticated users" do
    get login_url
    assert_response :success
    assert_select "form"
  end

  test "should redirect new for authenticated users" do
    sign_in_as(@user)
    get login_url
    assert_redirected_to root_path
    assert_equal "You are already signed in", flash[:notice]
  end

  test "should create session with valid credentials" do
    post login_url, params: { name: @user.name, password: "secret" }
    assert_redirected_to root_path
    assert_equal @user.id, session[:user_id]
    assert_equal "Hi, " + @user.name, flash[:notice]
  end

  test "should not create session with invalid credentials" do
    post login_url, params: { name: @user.name, password: "wrong" }
    assert_redirected_to login_url
    assert_equal "Invalid user/password combination", flash[:notice]
  end

  test "should destroy session" do
    sign_in_as(@user)
    delete logout_url
    assert_redirected_to root_path
    assert_equal "Logged out", flash[:notice]
  end

  private
  # Helper method to simulate an authenticated user
  def sign_in_as(user)
    post login_url, params: { name: user.name, password: "secret" }
    follow_redirect!
  end
end
