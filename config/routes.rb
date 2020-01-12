Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#analyses'

  get 'poe_trade_enhancer', to: 'dashboard#poe_trade_enhancer_integration', as: :pte_integration
  get 'generate_pte', to: 'dashboard#generate_pte', as: :generate_pte
  
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do 
      get 'analyses/save', to: "analyses#save"
      post 'analyses/update_league_analysis', to: "analyses#update_league_analysis"
    end
  end
end
