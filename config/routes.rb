Rails.application.routes.draw do

  root to: 'domains#edit', id: '1'

  resources :actions
  resources :achievements

  resources :domains do
    resources :actions
    resources :achievements
  end
  resources :action_fields do
    resources :actions
    resources :achievements
  end

end
