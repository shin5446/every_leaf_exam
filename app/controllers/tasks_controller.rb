class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      # if params # 入力がある場合の処理
      #   @tasks = Task.all
      #   @tasks = Task.where(['title LIKE ?', "%#{params["title"]}%"]) if params["title"]
      #   @tasks = Task.where(['status LIKE ?', "%#{params["status"]}%"]) if params["status"]
      #   # @tasks = Task.where(['status LIKE ? and title LIKE ?', "%#{params["status"]}%"], "%#{params["title"]}%"]) if params["status"] && params["title"]
      #   @tasks = Task.all.order(deadline: :desc) if  params[:sort_expired]
      # else
      #   @tasks = Task.all.order(created_at: :desc)
      # end
      if params[:sort_expired]
        @tasks = Task.all.order(deadline: :desc)
       elsif params[:task] != nil
          if params[:task][:search1] && params[:task][:search2]
            @tasks = Task.where("status LIKE ? and title LIKE ?" , "%#{ params[:task][:status] }%", "%#{ params[:task][:title] }%")
          elsif params[:task][:search1]
            @tasks = Task.where("status LIKE ?", "%#{ params[:task][:title] }%")
          else params[:task][:search2]
            @tasks = Task.where("title LIKE ?", "%#{ params[:task][:status] }%")
          end
       else
        @tasks = Task.all.order(created_at: :desc)
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

end