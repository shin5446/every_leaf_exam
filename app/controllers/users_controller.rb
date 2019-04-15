class UsersController < ApplicationController
  before_action :no_need_to_sign_in, only: [:new]
  before_action :correct_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def no_need_to_sign_in
    if logged_in?
      flash[:danger] = 'すでに登録済みです'
      redirect_to tasks_path
    end
  end

  def correct_user
    unless current_user.nil?
      unless current_user == User.find(params[:id])
        flash[:danger] = '他人のプロフィールは見れません！'
        redirect_to new_session_path
      end
    end
  end
end
