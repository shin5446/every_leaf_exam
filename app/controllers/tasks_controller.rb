class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      @tasks = Task.all.order(created_at: :desc)
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
      params.require(:task).permit(:title, :content, :priority, :limit, :status, :image, :user_id)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end