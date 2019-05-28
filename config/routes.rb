Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :customers do
          resources :orders do
            resources :line_items
          end
        end
      end
    end
  end
end
