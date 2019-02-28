class UsersController < ApplicationController
    before_action :no_need_to_sign_in, only: [:new]

    def new
      @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
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
        params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end

    def no_need_to_sign_in
      if logged_in?
        flash[:danger] = "すでに登録済みです"
        redirect_to tasks_path
      end
    end

end