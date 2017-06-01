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

  end

  def update

  end

  def destroy

  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
