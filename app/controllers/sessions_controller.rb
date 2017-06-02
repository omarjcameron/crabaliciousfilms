class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to root_path
    else
      @errors = ["Incorrect username or password"]
      # flash.now[:danger] = "Invalid login information"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
