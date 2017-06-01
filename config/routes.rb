Rails.application.routes.draw do
  root 'categories#index'

  resources :users, only: [:index, :new, :show, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :categories, only: [:index, :show]

  resources :films, except: [:index, :edit, :update]  do
    resources :reviews, except: [:index, :show]
    resources :ratings, except: [:index, :show]
  end
end

#           Prefix Verb   URI Pattern                                Controller#Action
#             root GET    /                                          categories#index
#            users GET    /users(.:format)                           users#index
#                  POST   /users(.:format)                           users#create
#         new_user GET    /users/new(.:format)                       users#new
#             user GET    /users/:id(.:format)                       users#show
#         sessions POST   /sessions(.:format)                        sessions#create
#      new_session GET    /sessions/new(.:format)                    sessions#new
#          session DELETE /sessions/:id(.:format)                    sessions#destroy
#       categories GET    /categories(.:format)                      categories#index
#         category GET    /categories/:id(.:format)                  categories#show
#     film_reviews POST   /films/:film_id/reviews(.:format)          reviews#create
#  new_film_review GET    /films/:film_id/reviews/new(.:format)      reviews#new
# edit_film_review GET    /films/:film_id/reviews/:id/edit(.:format) reviews#edit
#      film_review PATCH  /films/:film_id/reviews/:id(.:format)      reviews#update
#                  PUT    /films/:film_id/reviews/:id(.:format)      reviews#update
#                  DELETE /films/:film_id/reviews/:id(.:format)      reviews#destroy
#     film_ratings POST   /films/:film_id/ratings(.:format)          ratings#create
#  new_film_rating GET    /films/:film_id/ratings/new(.:format)      ratings#new
# edit_film_rating GET    /films/:film_id/ratings/:id/edit(.:format) ratings#edit
#      film_rating PATCH  /films/:film_id/ratings/:id(.:format)      ratings#update
#                  PUT    /films/:film_id/ratings/:id(.:format)      ratings#update
#                  DELETE /films/:film_id/ratings/:id(.:format)      ratings#destroy
#            films POST   /films(.:format)                           films#create
#         new_film GET    /films/new(.:format)                       films#new
#             film GET    /films/:id(.:format)                       films#show
#                  DELETE /films/:id(.:format)                       films#destroy
