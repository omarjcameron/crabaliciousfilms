class FilmsController < ApplicationController
  before_action :authorize, only: :new

  def index
    case params[:filter]
    when 'Highest Rated' then @films = Film.highest_rated
    when 'Top 5 Rated' then @films = Film.top_five_reviewed
    when 'Most Reviewed' then @films = Film.most_reviewed_list
    when 'Top 5 Reviewed' then @films = Film.top_five_reviewed
    when nil then @films = Film.all
    else @films = Film.by_category(params[:filter])
    end
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
