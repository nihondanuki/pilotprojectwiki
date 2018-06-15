class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])

    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
  end
end
