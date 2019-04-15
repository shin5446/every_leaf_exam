class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.includes(:tasks)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを登録しました'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path flash[:success] = 'ユーザーを編集しました'
    else
      flash[:danger] = 'このユーザーの管理者権限を外す事はできません'
      render :new
    end
  end

  def edit; end

  def destroy
    flash[:danger] = if @user.destroy
                       'ユーザーを削除しました'
                     else
                       '少なくとも1つ、ログイン用の認証が必要です'
                     end
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
    end
  end
end
