class CommentsController < ApplicationController
  def index
    if params[:user_id]
      render json: Comment.where(commentable_id: params[:user_id], commentable_type: "User")
    elsif params[:contact_id]
      render json: Comment.where(commentable_id: params[:contact_id], commentable_type: "Contact")
    else
      render json: Comment.all
    end
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    render json: @comment
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :contact_id, :body)
  end
end
