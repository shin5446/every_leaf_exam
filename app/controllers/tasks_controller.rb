class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

    def index
      if params[:sort_expired]
        @tasks = current_user.tasks.sort_deadline
        @tasks = current_user.tasks.page(params[:page]).per(8).sort_deadline
      elsif params[:sort_priority]
        @tasks = current_user.tasks.sort_priority
        @tasks = current_user.tasks.page(params[:page]).per(8).sort_priority
      else
        @tasks = current_user.tasks.sort_created_at
        @tasks = current_user.tasks.page(params[:page]).per(8)
      end

      if params[:task] != nil
      # if params[:task].present?
      # if params[:search] == "true"

        if params[:task][:title].present? && params[:task][:status].present?
          raise
          @tasks = current_user.tasks.search_title(params[:task][:title]).search_status(params[:task][:status])
          @tasks = current_user.tasks.page(params[:page]).per(8).search_title(params[:task][:title]).search_status(params[:task][:status])
          # @tasks = Task.search_title_status(params[:task][:title],params[:task][:status])
        elsif params[:task][:title].present?
          @tasks = current_user.tasks.search_title(params[:task][:title])
          @tasks = current_user.tasks.page(params[:page]).per(8).search_title(params[:task][:title])
        elsif params[:task][:status].present?
          @tasks = current_user.tasks.search_status(params[:task][:status])
          @tasks = current_user.tasks.page(params[:page]).per(8).search_status(params[:task][:status])
        else params[:task][:label_id].present?
          @tasks = current_user.tasks.search_label(params[:task][:label_id])
          @tasks = current_user.tasks.page(params[:page]).per(8).search_label(params[:task][:label_id])

          # labelids = Label.find(params[:task][:label_id]).task_labels
          # taskids = labelids.all.pluck(:task_id)
          # @tasks = current_user.tasks.where(id: taskids)
          # @tasks = current_user.tasks.page(params[:page]).per(8).where(id: taskids)
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

      # @task = Task.create(task_params.merge(user_id: corrent_user.id))
      # @task = corrent_user.tasks.new(task_params)
      # binding.pry
      @task = current_user.tasks.build(task_params)
      # binding.pry
      # @label_list =  params[:task][:label_ids]
      # raise
      if @task.save
        #  @label_list.save
         redirect_to tasks_path, notice: "タスクを作成しました"
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
      @task = current_user.tasks.build(task_params)
      # @label_list =  params[:labels]
      # raise
      render :new if @task.invalid?
    end

    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"タスクを削除しました！"
    end

    private

    def task_params
      params.require(:task).permit(:title, :content, :priority, :deadline, :status, :image, :user_id, :name,label_ids: [])
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください！"
        redirect_to new_session_path
      end
    end
end