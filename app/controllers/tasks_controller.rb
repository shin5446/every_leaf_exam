class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :logged_in_user

  def index
    @tasks = if params[:sort_expired]
               current_user.tasks.sort_deadline.page(params[:page]).per(8) # 終了期限で並べ替え
             elsif params[:sort_priority]
               current_user.tasks.sort_priority.page(params[:page]).per(8) # 優先順位で並べ替え
             else
               current_user.tasks.sort_created_at.page(params[:page]).per(8) # 作成日時で並べ替え
             end

    unless params[:task].nil?
      @tasks = if params[:task][:title].present? && params[:task][:status].present?
                current_user.tasks.search_title(params[:task][:title]).page(params[:page]).per(8) # タイトルと状態で検索
               elsif params[:task][:title].present?
                current_user.tasks.search_title(params[:task][:title]).page(params[:page]).per(8) # タイトルのみで検索
               elsif params[:task][:status].present?
                current_user.tasks.search_status(params[:task][:status]).page(params[:page]).per(8) # 状態のみで検索
               else params[:task][:label_id].present?
                current_user.tasks.search_label(params[:task][:label_id]).page(params[:page]).per(8) # ラベルで検索

        # 以下の方法でもラベル検索できるが、上記モデルにスコープを使って書いた方がスマート。下記は他の実装の参考にしたいのでコメントアウトして残しておく。
        # labelids = Label.find(params[:task][:label_id]).task_labels
        # taskids = labelids.all.pluck(:task_id)
        # @tasks = current_user.tasks.where(id: taskids)
        # @tasks = current_user.tasks.page(params[:page]).per(8).where(id: taskids)
      end
    end
  end

  def new
    @task = if params[:back]
              Task.new(task_params)
            else
              Task.new
            end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path flash[:success] = '登録しました'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path flash[:success] = '編集しました'
    else
      render 'edit'
    end
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  def destroy
    @task.destroy
    redirect_to tasks_path flash[:success] = 'タスクを削除しました！'
  end

  private

  def task_params
    params.require(:task).permit(:title,
                                 :content,
                                 :priority,
                                 :deadline,
                                 :status,
                                 :image,
                                 :user_id,
                                 :name,
                                 label_ids: [])
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  # ログインしてなければログイン画面に返す
  def logged_in_user
    unless logged_in?
      flash[:danger] = 'ログインしてください！'
      redirect_to new_session_path
    end
  end
end
