class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username:params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      login(@user)
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid login information"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
