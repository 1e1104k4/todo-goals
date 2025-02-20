class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_sign_in, only: %i[ edit update destroy ]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: "User #{@user.name} was successfully created." }
        format.json { render json: { message: "User #{@user.name} was successfully created." }, status: :created }
      else
          format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "User #{@user.name} was successfully updated." }
        format.json { render json: { message: "User #{@user.name} was successfully updated." }, status: :ok}
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "User #{@user.name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))

      unless current_user == @user
        redirect_to(root_path)
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :name, :password, :password_confirmation ])
    end
end
