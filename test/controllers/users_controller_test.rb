require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @another_user = users(:two)
  end

  test "should get new for unauthenticated users" do
    get new_user_url
    assert_response :success
    assert_select "form"
  end

  test "should redirect new for authenticated users" do
    sign_in_as(@user)
    get new_user_url
    assert_redirected_to root_path
    assert_equal "You are already signed in", flash[:notice]
  end

  test "should create user with valid credentials" do
    new_user = {
      name: "new user",
      password: "password",
      password_confirmation: "password"
    }
    assert_difference "User.count", 1 do
      post users_url, params: { user: new_user }
    end

    assert_redirected_to login_url
    assert_equal "User #{new_user[:name]} was successfully created.", flash[:notice]
  end

  test "should not create duplicate user" do
    assert_no_difference "User.count" do
      post users_url, params: { user: {
        name: @user.name,
        password: "password",
        password_confirmation: "password"
      } }
    end
    assert_response :unprocessable_entity
  end


  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should not allow get edit for non current user" do
    sign_in_as(@user)
    get edit_user_url(@another_user)
    assert_redirected_to root_path
  end

  test "should update user" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { name: "new name", password: "secret", password_confirmation: "secret" } }
    @user.reload
    assert_equal "new name", @user.name
    assert_redirected_to root_path
  end

  test "should destroy user" do
    sign_in_as(@user)
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_path
  end

  private
  # Helper method to simulate an authenticated user
  def sign_in_as(user)
    post login_url, params: { name: user.name, password: 'secret' }
    follow_redirect!
  end
end
