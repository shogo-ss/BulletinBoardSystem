class TopicsController < ApplicationController
  before_action :require_user_logged_in, except: [:index, :show]
  
  def index
    @topics = Topic.where(category_id: params[:category_id]).order(id: :desc).page(params[:page]).per(20)
    @category = Category.find(params[:category_id])
  end
  
  def new
    @topic = Topic.new
    @user = current_user
    #@topic.category_topics.build
  end
  
  def create
    @topic = Topic.new(topic_params)
    
    if @topic.save
      flash[:success] = '作成しました'
      redirect_to topic_path(@topic)
    
    else
      flash.now[:danger] = '作成に失敗しました。'
      @user = current_user
      render :new
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.order(id: :asc).page(params[:page]).per(50)
  end
  
  def edit
    @topic = Topic.find(params[:id])
    #@topic.category_topics.build
    @user = current_user
    unless @topic.user == @user
      redirect_to root_url
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    
    if @topic.update(topic_params)
      flash[:success] = 'トピックを編集しました。'
      redirect_to topic_path(@topic)
      
    else
      flash.now[:danger] = 'トピックの編集に失敗しました。'
      @user = current_user
      render :edit
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    flash[:success] = 'トピックを削除しました。'
    redirect_to root_url
  end
  
  private

  def topic_params
    params.require(:topic).permit(:name, :user_id, :category_id)
  end
end
