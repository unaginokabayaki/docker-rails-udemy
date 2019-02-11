class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      # render 'home/index'
      redirect_to root_path, flash: { error_messages: ["ログイン情報が正しくありません"] }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
