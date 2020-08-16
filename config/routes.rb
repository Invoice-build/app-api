Rails.application.routes.draw do
  root to: 'application#live'

  resources :invoices, only: [:show, :create, :update] do
    resources :eth_transactions, only: [:show, :index, :create], controller: 'invoices/eth_transactions'
  end
  resources :tokens, only: [:index]
end
