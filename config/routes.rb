Rails.application.routes.draw do

  scope 'api', defaults: {format: 'json'} do
    resources :locations, only: [:index]
    resources :main_entries, except: [:new, :edit], path: 'mes'
    resources :sub_entries, except: [:new, :edit], path: 'ses' do
      resources :media, only: [:create, :update, :destroy]

      collection do
        get :autocomplete
      end
    end
  end

end
