class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[show update]
  before_action :correct_user, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User Created'
      redirect_to login_path
    else
      flash[:danger] = 'User Creation failed'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'User updated'
      redirect_to current_user
    else
      flash[:danger] = 'User update failed'
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname, :coverimage, :photo)
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
