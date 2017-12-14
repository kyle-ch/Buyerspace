Rails.application.routes.draw do
  get 'seller/all'

  get 'seller/show'

  get 'seller/search'

  get 'seller/tag'

  get 'seller/offer'

  get 'seller/delete'

  get '/seller', to: 'seller#all'

  get 'postings/create'

  get 'postings/show'

  get 'postings/edit'

  get 'postings/delete'

  get 'postings/offers'

  get 'postings/all'

  get 'postings/update'

  get 'postings/new'

  get 'postings/accept'

  get 'postings/decline'

  get 'postings', to: 'postings#all'

  get 'postings/rate'

  root 'login#index'

  get '/login', to: 'login#login'
  get 'login/login'

  get 'login/new'

  get 'login/create'

  get 'login/sellerlogin'

  get 'login/sellernew'

  get 'login/sellercreate'

  resources :buyers, :offers, :sellers, :postings, :ratings, :tags
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
