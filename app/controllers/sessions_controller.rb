class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  def new
  end

  def create
    user = User.find_by name: params[:name]
    if user&.authenticate(params[:password])
      sign_in user
      redirect_to root_path, notice: "Hi, #{current_user.name}"
    else
      # flash.now[:notice] = "Invalid user/password combination"
      # render :new
      redirect_to login_url, notice: "Invalid user/password combination"
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: "Logged out"
  end
end
