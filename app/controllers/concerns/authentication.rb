module Authentication
  extend ActiveSupport::Concern

  included do
    private
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
      current_user.present?
    end

    def require_no_authentication
      return unless user_signed_in?
      redirect_to root_path, notice: "You are already signed in"
    end

    def require_sign_in
      unless user_signed_in?
        if request.path != root_path
          redirect_to root_path, notice: "Please Sign In"
        else
          flash.now[:notice] = "Please Sign In"
          render "guest/guest"
        end
      end
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete :user_id # session[:user_id] = nil
      @current_user = nil
    end

    helper_method :current_user
  end
end
