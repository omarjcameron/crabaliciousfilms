class RatingsController < ApplicationController
  def new
    @film = Film.find(params[:film_id])
    @rating = Rating.new
  end

  def create
    @film = Film.find(params[:film_id])
    @rating = @film.ratings.build(rating_params)
    @rating.user_id = User.all.sample.id

    if @rating.save
      redirect_to @film
    else
      flash[:errors] = @rating.errors.full_messages
      render 'new'
    end
  end

  def edit

  end

  def destroy

  end

  private

  def rating_params
    params.require(:rating).permit(:stars)
  end
end
