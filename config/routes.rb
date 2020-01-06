Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#analyses'

  get 'poe_trade_enhancer', to: 'dashboard#poe_trade_enhancer_integration'
  
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      get 'analyses/save', to: "analyses#save"
      post 'analyses/update_season_analysis', to: "analyses#update_season_analysis"
    end
  end
end
