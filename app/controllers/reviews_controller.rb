class ReviewsController < ApplicationController
  def new
    @film = Film.find(params[:film_id])
    @review = Review.new
  end

  def create
    @film = Film.find(params[:film_id])
    @review = @film.reviews.build(review_params)
    @review.user_id = User.all.sample.id

    if @review.save
      redirect_to @film
    else
      flash[:errors] = @review.errors.full_messages
      redirect_to new_film_review_path(@film)
    end
  end

  def edit
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
  end

  def update
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to @film
    else
      flash[:errors] = @review.errors.full_messages
      redirect_to edit_film_review_path(@film , @review)
    end
  end

  def destroy
    @film = Film.find(params[:film_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to @film
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
