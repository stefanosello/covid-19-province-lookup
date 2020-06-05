Rails.application.routes.draw do
  get 'landing_page/index'
  root to: "landing_page#index"

  namespace :api do
    namespace :v1 do
      get 'epidemic-data/:province', to: 'epidemic_data#get_by_province', defaults: {format: 'json'}
      get 'geo-data/province-by-coords', to: 'geo_data#get_nearest_province', defaults: {format: 'json'}
      get 'geo-data(/:nation)(/:region)', to: 'geo_data#get', defaults: {format: 'json'}
    end
  end
end
