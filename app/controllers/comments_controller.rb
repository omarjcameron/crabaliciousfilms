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
    @review = Review.find(params[:review_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @review = Review.find(params[:review_id])
    @comment = Comment.find(params[:id])
    @comment.assign_attributes(comment_params)

    if @comment.save
      redirect_to @review.film
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to edit_review_comment_path(@review , @comment)
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @review.film
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end