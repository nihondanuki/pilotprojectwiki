class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def require_login
      unless logged_in?
        flash[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
end
