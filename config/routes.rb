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
