class FilmsController < ApplicationController
  before_action :authorize, only: :new

  def index
    @films = Film.where(nil)
    @films = @films.most_reviewed(params[:most_reviewed]) if params[:most_reviewed].present?
    @films = @films.highest_rated(params[:highest_rated]) if params[:highest_rated].present?
    @films = @films.by_category(params[:by_category]) if params[:by_category].present?
    @films = @films.top_five_reviewed(params[:top_five_reviewed]) if params[:top_five_reviewed].present?
    @films = @films.most_reviewed_list(params[:most_reviewed_list]) if params[:most_reviewed_list].present?
  end

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
    @film = Film.find(params[:id])
    @film.destroy

    redirect_to root_path
  end

  private
    def film_params
      params.require(:film).permit(:title)
    end

    def category_params
      params.require(:film).permit(:category)
    end
end
