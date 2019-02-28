class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
    def index
      if params[:sort_expired]
        @tasks = Task.all.sort_deadline
        @tasks = Task.page(params[:page]).per(8).sort_deadline
      elsif params[:sort_priority]
        @tasks = Task.all.sort_priority
        @tasks = Task.page(params[:page]).per(8).sort_priority
      else
        @tasks = Task.all.sort_created_at
        @tasks = Task.page(params[:page]).per(8)
      end

      if params[:task] != nil
      # if params[:task].present?
      # if params[:search] == "true"
        if params[:task][:title] && params[:task][:status]
          @tasks = Task.search_title(params[:task][:title]).search_status(params[:task][:status])
          @tasks = Task.page(params[:page]).per(8).search_title(params[:task][:title]).search_status(params[:task][:status])
          # @tasks = Task.search_title_status(params[:task][:title],params[:task][:status])
        elsif params[:task][:title]
          @tasks = Task.search_title(params[:task][:title])
          @tasks = Task.page(params[:page]).per(8).search_title(params[:task][:title])
        else params[:task][:status]
          @tasks = Task.search_status(params[:task][:status])
          @tasks = Task.page(params[:page]).per(8).search_status(params[:task][:status])
        end
      end

    end

    def new
      if params[:back]
        @task = Task.new(task_params)
      else
        @task = Task.new
      end
    end

    def create
      @task = Task.create(task_params)
      if @task.save
        redirect_to tasks_path, notice: "タスクを作成いたしました"
      else
        render 'new'
      end
    end

    def show

    end

    def edit

    end

    def update
      if @task.update(task_params)
        redirect_to tasks_path, notice: "タスクを編集しました！"
      else
        render 'edit'
      end
    end

    def confirm
      @task = Task.new(task_params)
      render :new if @task.invalid?
    end

    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"タスクを削除しました！"
    end

    private

    def task_params
      params.require(:task).permit(:title, :content, :priority, :deadline, :status, :image, :user_id,)
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください！"
        redirect_to new_session_path
      end
    end

end