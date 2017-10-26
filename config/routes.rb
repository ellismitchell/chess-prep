Rails.application.routes.draw do
	get '/chessboard', to: 'chessboard#chessboard'
	get '/position', to: 'chessboard#position'
	get '/drill', to: 'chessboard#drill'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'chessboard#chessboard'

  get 'users/new', to: 'users#new', as: 'new_user'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  post '/sessions', to: 'sessions#create'

  post '/moves', to: 'moves#create'
  get '/moves', to: 'moves#next_due_move'
  get '/moves/new', to: 'moves#new', as: 'new_move'
  post '/moves/:id/correct', to: 'moves#correct'
  post '/moves/:id/incorrect', to: 'moves#incorrect'

  get '/positions', to: 'positions#index', as: 'positions'

  post '/positions', to: 'positions#create', as: 'create_position'
end
