class CommentsController < ApplicationController
  def new 
    @review = Review.find(params[:review_id])
    @comment = Comment.new
  end

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = User.all.sample

    if @comment.save
      redirect_to @review.film
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_review_comment_path(@review)
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end