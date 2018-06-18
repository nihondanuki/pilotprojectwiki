class SessionsController < ApplicationController
  def new
  end
<<<<<<< Updated upstream
=======

  def create
    user = User.find_by(session_params_email)
    if user && user.authenticate(session_params_password)
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out
    render 'new'
  end

  private

    def session_params_email
      params.require(:session).permit(:email)
    end

    def session_params_password
      params.require(:session).permit(:password)[:password]
    end
end
