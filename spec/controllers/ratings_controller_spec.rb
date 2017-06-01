require 'rails_helper'

describe RatingsController do
  describe 'GET #new' do
    it 'responds with status code 200' do
      get :new, params: { film_id: Film.first.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      get :new, params: { film_id: Film.first.id }
      expect(assigns(:rating)).to be_a_new Rating
    end

    it 'assigns a new rating to @rating' do
      get :new, params: { film_id: Film.first.id }
      expect(assigns(:film)).to eq Film.first
    end

    it 'renders the new template' do
      get :new, params: { film_id: Film.first.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      it 'responds with status code 302' do
        post :create, params: { film_id: Film.first.id, rating: { stars: 4 } }
        expect(response).to have_http_status 302
      end

      it 'creates a new rating in the database' do
        expect { post(:create, params: { film_id: Film.first.id, rating: { stars: 4 } }) }.to change(Rating, :count).by(1)
      end

      it 'assigns the newly created rating as @rating' do
        post :create, params: { film_id: Film.first.id, rating: { stars: 4 } }
        expect(assigns(:rating)).to eq Rating.last
      end

      it 'assigns the newly created rating to the correct film' do
        post :create, params: { film_id: Film.first.id, rating: { stars: 4 } }
        expect(assigns(:film).ratings.last).to eq Rating.last
      end

      it 'redirects to the film page of the newly created rating' do
        post :create, params: { film_id: Film.first.id, rating: { stars: 4 } }
        expect(response).to redirect_to film_path(Rating.last.film)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that rating was not created' do
        post :create, params: { film_id: Film.first.id, rating: { stars: nil } }
        expect(flash[:errors][0]).to eq "Stars can't be blank"
      end

      it 'does not create a new rating in the database' do
        expect { post(:create, params: { film_id: Film.first.id, rating: { stars: nil } }) }.to change(Rating, :count).by(0)
      end

      it 'assigns the unsaved rating as @rating' do
        post :create, params: { film_id: Film.first.id, rating: { stars: nil } }
        expect(assigns(:rating)).to be_a_new Rating
      end

      it 'redirects to the new film rating path' do
        post :create, params: { film_id: Film.first.id, rating: { stars: nil } }
        expect(response).to redirect_to new_film_rating_path(Film.first)
      end
    end
  end
end
