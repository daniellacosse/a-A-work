
class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to :back
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :author_id)
  end


end

# can comment from user's show page or goal's show page