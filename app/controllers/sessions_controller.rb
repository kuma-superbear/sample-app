class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    # ユーザーログイン後にユーザー情報のページにリダイレクトする
    # => User object or false. Success
      log_in user
      redirect_to user
    else
      # failure
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # DELETE /logout
  def destroy
    log_out
    redirect_to root_url
  end
end