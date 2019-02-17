class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
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

    end

    def destroy

    end

    private

    def task_params
      params.require(:task).permit(:title, :content, :priority, :limit, :status, :image, :user_id)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end