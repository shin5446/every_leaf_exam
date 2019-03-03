class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin
  def index
    @users = User.includes(:tasks)
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを登録しました"
    else
      render :new
    end
  end

  def update

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを編集しました"
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,:password_confirmation)
  end

  def require_admin
    raise unless current_user.admin?
  end
end
