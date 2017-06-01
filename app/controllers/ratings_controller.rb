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
      redirect_to new_film_rating_path(@film)
    end
  end

  def edit
    @film = Film.find(params[:film_id])
    @rating = Rating.find(params[:id])
  end

  def update
    @film = Film.find(params[:film_id])
    @rating = Rating.find(params[:id])
    @rating.assign_attributes(rating_params)

    if @rating.save
      redirect_to @film
    else
      flash[:errors] = @rating.errors.full_messages
      redirect_to edit_film_rating_path(@film , @rating)
    end
  end

  def destroy
    @film = Film.find(params[:film_id])
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_to @film
  end

  private

  def rating_params
    params.require(:rating).permit(:stars)
  end
end
