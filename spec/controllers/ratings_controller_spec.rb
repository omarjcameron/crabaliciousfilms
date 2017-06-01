require 'rails_helper'

describe RatingsController do
  describe 'GET #new' do
    it 'responds with status code 200' do
      get :new, params: { film_id: Film.first.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      get :new, params: { film_id: Film.first.id }
      expect(assigns(:film)).to eq Film.first
    end

    it 'assigns a new rating to @rating' do
      get :new, params: { film_id: Film.first.id }
      expect(assigns(:rating)).to be_a_new Rating
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

  describe 'GET #edit' do
    let(:film) { Rating.first.film }

    it 'responds with status code 200' do
      get :edit, params: { film_id: film.id, id: Rating.first.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      get :edit, params: { film_id: film.id, id: Rating.first.id }
      expect(assigns(:film)).to eq film
    end

    it 'assigns the correct rating to @rating' do
      get :edit, params: { film_id: film.id, id: Rating.first.id }
      expect(assigns(:rating)).to eq Rating.first
    end

    it 'renders the edit template' do
      get :edit, params: { film_id: film.id, id: Rating.first.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:film) { Rating.first.film }

    context 'when valid params are passed' do
      it 'responds with status code 302' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: 2 } }
        expect(response).to have_http_status 302
      end

      it 'updates the rating in the database' do
        Rating.first.update_attributes(stars: 4)
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: 2 } }
        expect(Rating.first.stars).to eq 2
      end

      it 'assigns the correct film to @film' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: 2 } }
        expect(assigns(:film)).to eq film
      end

      it 'assigns the correct rating to @rating' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: 2 } }
        expect(assigns(:rating)).to eq Rating.first
      end

      it 'redirects to the film page of the updated rating' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: 2 } }
        expect(response).to redirect_to film_path(film)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that rating was not created' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: nil } }
        expect(flash[:errors][0]).to eq "Stars can't be blank"
      end

      it 'does not update the rating in the database' do
        Rating.first.update_attributes(stars: 4)
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: nil } }
        expect(Rating.first.stars).to eq 4
      end

      it 'assigns the unsaved rating as @rating' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: nil } }
        expect(assigns(:rating)).to eq Rating.first
      end

      it 'redirects to the edit film rating path' do
        patch :update, params: { film_id: film.id, id: Rating.first.id, rating: { stars: nil } }
        expect(response).to redirect_to edit_film_rating_path(film, Rating.first)
      end
    end
  end

end
