Rails.application.routes.draw do
  get 'landing_page/index'
  root to: "landing_page#index"
end
