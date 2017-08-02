require 'rails_helper'

describe RatingsController do
  let(:film) { Film.first }
  let(:rating) { Rating.first }
  let(:first_rating_film) { Rating.first.film }

  let(:user) { User.first }
  before { allow(controller).to receive(:current_user) { user } }

  describe 'GET #new' do
    before(:each) do
      session[:id] = '1'
      get :new, params: { film_id: film.id }
    end
    
    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      expect(assigns(:film)).to eq film
    end

    it 'assigns a new rating to @rating' do
      expect(assigns(:rating)).to be_a_new Rating
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      before(:each) do |test|
        post :create, params: { film_id: film.id, rating: { stars: 4 } } unless test.metadata[:has_request]
      end

      it 'responds with status code 302' do
        expect(response).to have_http_status 302
      end

      it 'creates a new rating in the database', :has_request do
        expect { post(:create, params: { film_id: film.id, rating: { stars: 4 } }) }.to change(Rating, :count).by(1)
      end

      it 'assigns the newly created rating as @rating' do
        expect(assigns(:rating)).to eq Rating.last
      end

      it 'assigns the newly created rating to the correct film' do
        expect(assigns(:film).ratings.last).to eq Rating.last
      end

      it 'redirects to the film page of the newly created rating' do
        expect(response).to redirect_to film_path(Rating.last.film)
      end
    end

    context 'when invalid params are passed' do
      before(:each) do |test|
        post :create, params: { film_id: film.id, rating: { stars: nil } } unless test.metadata[:has_request]   
      end

      it 'sets error message that rating was not created' do
        expect(flash[:errors][0]).to eq "Stars can't be blank"
      end

      it 'does not create a new rating in the database', :has_request do
        expect { post(:create, params: { film_id: film.id, rating: { stars: nil } }) }.to change(Rating, :count).by(0)
      end

      it 'assigns the unsaved rating as @rating' do
        expect(assigns(:rating)).to be_a_new Rating
      end

      it 'redirects to the new film rating path' do
        expect(response).to redirect_to new_film_rating_path(film)
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      get :edit, params: { film_id: first_rating_film.id, id: rating.id }
    end

    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      expect(assigns(:film)).to eq first_rating_film
    end

    it 'assigns the correct rating to @rating' do
      expect(assigns(:rating)).to eq rating
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'when valid params are passed' do
      before(:each) do |test|
        patch :update, params: { film_id: first_rating_film.id, id: rating.id, rating: { stars: 2 } } unless test.metadata[:has_request]       
      end

      it 'responds with status code 302' do
        expect(response).to have_http_status 302
      end

      it 'updates the rating in the database', :has_request do
        rating.update_attributes(stars: 4)
        patch :update, params: { film_id: first_rating_film.id, id: rating.id, rating: { stars: 2 } }
        expect(assigns(:rating).stars).to eq 2
      end

      it 'assigns the correct film to @film' do
        expect(assigns(:film)).to eq first_rating_film
      end

      it 'assigns the correct rating to @rating' do
        expect(assigns(:rating)).to eq rating
      end

      it 'redirects to the film page of the updated rating' do
        expect(response).to redirect_to film_path(first_rating_film)
      end
    end

    context 'when invalid params are passed' do
      before(:each) do |test|
        patch :update, params: { film_id: first_rating_film.id, id: rating.id, rating: { stars: nil } } unless test.metadata[:has_request]        
      end

      it 'sets error message that rating was not created' do
        expect(flash[:errors][0]).to eq "Stars can't be blank"
      end

      it 'does not update the rating in the database', :has_request do
        rating.update_attributes(stars: 4)
        patch :update, params: { film_id: first_rating_film.id, id: rating.id, rating: { stars: nil } }
        rating.reload
        expect(rating.stars).to eq 4
      end

      it 'assigns the unsaved rating as @rating' do
        expect(assigns(:rating)).to eq rating
      end

      it 'redirects to the edit film rating path' do
        expect(response).to redirect_to edit_film_rating_path(first_rating_film, rating)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do |test|
      delete :destroy, params: { film_id: first_rating_film.id, id: rating.id } unless test.metadata[:has_request]      
    end

    it 'responds with status code 302' do
      expect(response).to have_http_status 302
    end

    it 'destroys the requested rating', :has_request do
      expect { delete(:destroy, params: { film_id: first_rating_film.id, id: rating.id }) }.to change(Rating, :count).by(-1)
    end

    it 'redirects to the film path' do
      expect(response).to redirect_to film_path(first_rating_film)
    end
  end
end
