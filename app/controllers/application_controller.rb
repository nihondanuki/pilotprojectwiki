class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def login_watch
      unless logged_in?
        flash.now[:danger] = "ログインが必要です"
        redirect_to login_url
      end
    end
end
