class FilmsController < ApplicationController
  before_action :authorize, only: :new

  def index
    if params[:filter]
      case params[:filter]
      when 'Highest Rated' then @films = Film.highest_rated
      when 'Top 5 Rated' then @films = Film.top_five_rated
      when 'Most Reviewed' then @films = Film.most_reviewed_list
      when 'Top 5 Reviewed' then @films = Film.top_five_reviewed
      when 'All Films' then @films = Film.all
      else @films = Film.by_category(params[:filter])
      end
    else
      @films = Film.all
    end
  end

  def create
    @film = Film.new(film_params)
    @film.category = Category.find_by(name: category_params[:category])

    respond_to do |format|
      if @film.save
        format.html {redirect_to category_path(@film.category)}
        format.json
      else
        format.html { render action: 'new' }
        format.js { render status: 500 }
        # flash[:errors] = @film.errors.full_messages
        # redirect_to new_film_path
      end
    end
  end

  def new
    @film = Film.new
    respond_to do |format|
      format.html { redirect_to new_film_path }
      format.js
    end
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
