class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_i18n_locate_from_params
  
  before_action :authorize
  
  protected
    
    def authorize
      respond_to do |format|
        format.html {
          unless User.find_by(id: session[:user_id])
            redirect_to login_url, notice: "Please log in" 
          end
        }
        format.any {
          authenticate_or_request_with_http_basic do |username, password|
            user = User.find_by(name: username)
            user && user.try(:authenticate, password)
          end
        }
      end
    end
    
    def set_i18n_locate_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
  
end
