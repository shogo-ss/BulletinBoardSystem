class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @comment = Comment.new
    @user = current_user
    @topic = Topic.find(params[:topic_id])
  end
  
  def create
    @comment = Comment.new(comment_params)
    
    if @comment.save
      flash[:success] = 'コメントしました'
      redirect_to topic_path(@comment.topic.id)
    
    else
      flash.now[:danger] = 'コメントに失敗しました。'
      @user = current_user
      @topic = Topic.find(params[:topic_id])
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @topic = Topic.find(@comment.topic.id)
    @user = current_user
    unless @comment.user == current_user
      redirect_to root_url
    end
  end

  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update(comment_params)
      flash[:success] = 'コメントを編集しました。'
      redirect_to topic_path(@comment.topic.id)
      
    else
      flash.now[:danger] = 'コメントの編集に失敗しました。'
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :topic_id)
  end
end
