require 'rails_helper'

describe ReviewsController do
  let(:film) { Film.first }
  let(:review) { Review.first }
  let(:first_review_film) { Review.first.film }

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

    it 'assigns a new review to @review' do
      expect(assigns(:review)).to be_a_new Review
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      it 'responds with status code 302' do
        post :create, params: { film_id: film.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(response).to have_http_status 302
      end

      it 'creates a new review in the database' do
        expect { post(:create, params: { film_id: film.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }) }.to change(Review, :count).by(1)
      end

      it 'assigns the newly created review as @review' do
        post :create, params: { film_id: film.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(assigns(:review)).to eq Review.last
      end

      it 'assigns the newly created review to the correct film' do
        post :create, params: { film_id: film.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(assigns(:film).reviews.last).to eq Review.last
      end

      it 'redirects to the film page of the newly created review' do
        post :create, params: { film_id: film.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(response).to redirect_to film_path(Review.last.film)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that review was not created' do
        post :create, params: { film_id: film.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(flash[:errors][0]).to eq "Title can't be blank"
      end

      it 'does not create a new review in the database' do
        expect { post(:create, params: { film_id: film.id, review: { title: '', body: 'I enjoyed this one' } }) }.to change(Review, :count).by(0)
      end

      it 'assigns the unsaved review as @review' do
        post :create, params: { film_id: film.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(assigns(:review)).to be_a_new Review
      end

      it 'redirects to the new film review path' do
        post :create, params: { film_id: film.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(response).to redirect_to new_film_review_path(film)
      end
    end
  end

  describe 'GET #edit' do
    it 'responds with status code 200' do
      get :edit, params: { film_id: first_review_film.id, id: review.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      get :edit, params: { film_id: first_review_film.id, id: review.id }
      expect(assigns(:film)).to eq first_review_film
    end

    it 'assigns the correct review to @review' do
      get :edit, params: { film_id: first_review_film.id, id: review.id }
      expect(assigns(:review)).to eq review
    end

    it 'renders the edit template' do
      get :edit, params: { film_id: first_review_film.id, id: review.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'when valid params are passed' do
      it 'responds with status code 302' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(response).to have_http_status 302
      end

      it 'updates the review in the database' do
        review.update_attributes(title: 'Great movie')
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Bad movie' } }
        expect(assigns(:review).title).to eq 'Bad movie'
      end

      it 'assigns the correct film to @film' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(assigns(:film)).to eq first_review_film
      end

      it 'assigns the correct review to @review' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(assigns(:review)).to eq review
      end

      it 'redirects to the film page of the updated review' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
        expect(response).to redirect_to film_path(first_review_film)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that review was not created' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(flash[:errors][0]).to eq "Title can't be blank"
      end

      it 'does not update the review in the database' do
        review.update_attributes(body: 'New Body')
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
        review.reload
        expect(review.body).to eq 'New Body'
      end

      it 'assigns the unsaved review as @review' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(assigns(:review)).to eq review
      end

      it 'redirects to the edit film review path' do
        patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
        expect(response).to redirect_to edit_film_review_path(first_review_film, review)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with status code 302' do
      delete :destroy, params: { film_id: first_review_film.id, id: review.id }
      expect(response).to have_http_status 302
    end

    it 'destroys the requested review' do
      expect { delete(:destroy, params: { film_id: first_review_film.id, id: review.id }) }.to change(Review, :count).by(-1)
    end

    it 'redirects to the film path' do
      delete :destroy, params: { film_id: first_review_film.id, id: review.id }
      expect(response).to redirect_to film_path(first_review_film)
    end
  end
end
