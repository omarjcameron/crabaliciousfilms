class FilmsController < ApplicationController
  def create
    @film = Film.new(film_params)
    @film.category = Category.find_by(name: category_params[:category])

    if @film.save
      redirect_to category_path(@film.category)
    else
      flash[:errors] = @film.errors.full_messages
      redirect_to new_film_path
    end
  end

  def new
    @film = Film.new
  end

  def show
    @film = Film.find(params[:id])
  end

  def destroy

  end

  private
    def film_params
      params.require(:film).permit(:title)
    end

    def category_params
      params.require(:film).permit(:category)
    end
end
