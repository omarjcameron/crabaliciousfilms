class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Tell the UserMailer to send a welcome email after save
      UserMailer.welcome_email(@user).deliver_now
      login(@user)
      redirect_to root_path
    else
      render "new"
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
