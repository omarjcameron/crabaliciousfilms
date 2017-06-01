require 'rails_helper'

describe CommentsController do
  let(:review) { Review.first }
  let(:comment) { Comment.first }
  let(:first_comment_review) { Comment.first.review }

  describe 'GET #new' do
    it 'responds with status code 200' do
      get :new, params: { review_id: review.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct review to @review' do
      get :new, params: { review_id: review.id }
      expect(assigns(:review)).to eq review
    end

    it 'assigns a new comment to @comment' do
      get :new, params: { review_id: review.id }
      expect(assigns(:comment)).to be_a_new Comment
    end

    it 'renders the new template' do
      get :new, params: { review_id: review.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      it 'responds with status code 302' do
        post :create, params: { review_id: review.id, comment: { content: 'This is a comment' } }
        expect(response).to have_http_status 302
      end

      it 'creates a new comment in the database' do
        expect { post(:create, params: { review_id: review.id, comment: { content: 'This is a comment' } }) }.to change(Comment, :count).by(1)
      end

      it 'assigns the newly created comment as @comment' do
        post :create, params: { review_id: review.id, comment: { content: 'This is a comment' } }
        expect(assigns(:comment)).to eq Comment.last
      end

      it 'assigns the newly created comment to the correct review' do
        post :create, params: { review_id: review.id, comment: { content: 'This is a comment' } }
        expect(assigns(:review).comments.last).to eq Comment.last
      end

      it 'redirects to the film page of the newly created comment' do
        post :create, params: { review_id: review.id, comment: { content: 'This is a comment' } }
        expect(response).to redirect_to film_path(Comment.last.review.film)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that comment was not created' do
        post :create, params: { review_id: review.id, comment: { content: '' } }
        expect(flash[:errors][0]).to eq "Content can't be blank"
      end

      it 'does not create a new comment in the database' do
        expect { post(:create, params: { review_id: review.id, comment: { content: '' } }) }.to change(Comment, :count).by(0)
      end

      it 'assigns the unsaved comment as @comment' do
        post :create, params: { review_id: review.id, comment: { content: '' } }
        expect(assigns(:comment)).to be_a_new Comment
      end

      it 'redirects to the new review comment path' do
        post :create, params: { review_id: review.id, comment: { content: '' } }
        expect(response).to redirect_to new_review_comment_path(review)
      end
    end
  end

  # describe 'GET #edit' do
  #   it 'responds with status code 200' do
  #     get :edit, params: { film_id: first_review_film.id, id: review.id }
  #     expect(response).to have_http_status 200
  #   end

  #   it 'assigns the correct film to @film' do
  #     get :edit, params: { film_id: first_review_film.id, id: review.id }
  #     expect(assigns(:film)).to eq first_review_film
  #   end

  #   it 'assigns the correct review to @review' do
  #     get :edit, params: { film_id: first_review_film.id, id: review.id }
  #     expect(assigns(:review)).to eq review
  #   end

  #   it 'renders the edit template' do
  #     get :edit, params: { film_id: first_review_film.id, id: review.id }
  #     expect(response).to render_template(:edit)
  #   end
  # end

  # describe 'PATCH #update' do
  #   context 'when valid params are passed' do
  #     it 'responds with status code 302' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
  #       expect(response).to have_http_status 302
  #     end

  #     it 'updates the review in the database' do
  #       review.update_attributes(title: 'Great movie')
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Bad movie' } }
  #       expect(assigns(:review).title).to eq 'Bad movie'
  #     end

  #     it 'assigns the correct film to @film' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
  #       expect(assigns(:film)).to eq first_review_film
  #     end

  #     it 'assigns the correct review to @review' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
  #       expect(assigns(:review)).to eq review
  #     end

  #     it 'redirects to the film page of the updated review' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: 'Good movie', body: 'I enjoyed this one' } }
  #       expect(response).to redirect_to film_path(first_review_film)
  #     end
  #   end

  #   context 'when invalid params are passed' do
  #     it 'sets error message that review was not created' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
  #       expect(flash[:errors][0]).to eq "Title can't be blank"
  #     end

  #     it 'does not update the review in the database' do
  #       review.update_attributes(body: 'New Body')
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
  #       review.reload
  #       expect(review.body).to eq 'New Body'
  #     end

  #     it 'assigns the unsaved review as @review' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
  #       expect(assigns(:review)).to eq review
  #     end

  #     it 'redirects to the edit film review path' do
  #       patch :update, params: { film_id: first_review_film.id, id: review.id, review: { title: '', body: 'I enjoyed this one' } }
  #       expect(response).to redirect_to edit_film_review_path(first_review_film, review)
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'responds with status code 302' do
  #     delete :destroy, params: { film_id: first_review_film.id, id: review.id }
  #     expect(response).to have_http_status 302
  #   end

  #   it 'destroys the requested review' do
  #     expect { delete(:destroy, params: { film_id: first_review_film.id, id: review.id }) }.to change(Review, :count).by(-1)
  #   end

  #   it 'redirects to the film path' do
  #     delete :destroy, params: { film_id: first_review_film.id, id: review.id }
  #     expect(response).to redirect_to film_path(first_review_film)
  #   end
  # end
end
