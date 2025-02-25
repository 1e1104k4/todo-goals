class GoalsController < ApplicationController
  before_action :require_sign_in
  before_action :set_user
  before_action :set_goal, only: %i[ edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_goal

  # GET /goals or /goals.json
  def index
    @goals = @user.goals
  end

  # # GET /goals/1 or /goals/1.json
  # def show
  # end

  # # GET /goals/new
  # def new
  #   @goal = Goal.new
  # end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals or /goals.json
  def create
    @goal = @user.goals.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Goal was successfully created." }
        format.json { render :show, status: :created, location: @goal }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@goal)}_form", partial: "form", locals: { goal: @goal }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Goal was successfully updated." }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@goal)}_form", partial: "form", locals: { goal: @goal }) }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1 or /goals/1.json
  def destroy
    @goal.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@goal)}"), notice: "Goal was successfully destroyed." }
      format.html { redirect_to root_path, status: :see_other, notice: "Goal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find_by(id: session[:user_id]) if session[:user_id]
      # todo if user is undefined - redirect to login
      redirect_to login_path unless @user
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = @user.goals.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def goal_params
      params.expect(goal: [ :title, :description, :status ])
    end

    def invalid_goal
      logger.error "Attempt to access invalid goal #{params[:id]}"
      redirect_to root_path, notice: "ERROR"
    end
end
