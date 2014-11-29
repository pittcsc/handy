module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :current_user
  end

  module ClassMethods
    def skip_authentication(options = {})
      skip_before_action :require_authentication, options.slice(:only, :except)
    end
  end

  private
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def require_authentication
      unless current_user
        respond_to do |format|
          format.html { redirect_to login_url }
          format.any { head :unauthorized }
        end
      end
    end
end
