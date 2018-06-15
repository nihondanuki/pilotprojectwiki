class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out
  end

  private

    def session_params_email
      params.require(:session).permit(:email)
    end

    def session_params_password
      params.require(:session).permit(:password)
    end
end
