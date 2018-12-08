# -*- coding: utf-8 -*-
Rails.application.routes.draw do

  devise_for :users, :path => "/", :skip => [:confirmations],
    :controllers => {:sessions => "sessions", :passwords => "passwords", :registrations => "registrations", :sign_up => 'no_sign_up',},
    :path_names => {:sign_in => 'login', :sign_out => 'logout', :registration => "profile"}

  root :to => 'tops#show'
  resource :top, :only => [:show]

  get  'operative_settings/control_panel', to: 'operative_settings#control_panel'
  post 'operative_settings/control_panel', to: 'operative_settings#control_panel'

  resource :security_policy, :except => [:destroy] do
    post :change_status, :on => :member
  end
  resource :accounts_setting, :except => [:destroy] do
    post :change_status, :on => :member
  end

  get '/company_banks/search_bank', to: 'company_banks#search_bank'
  get '/company_banks/search_branch', to: 'company_banks#search_branch'
  resources :company_banks

  resource :date_bank_payment
  resource :date_bank_settlement
  resource :payment_notice

  resources :receivables do
    get :search_bank, on: :collection
    get :search_branch, on: :collection
    get :make_modal, on: :collection
    get :search, on: :collection
    get :result, on: :collection
  end
  namespace :receivables do
    resources :settlements do
      get :search, on: :collection
      get :result, on: :collection
      post :select, on: :collection
      post :confirm, on: :collection
      post :update_all, on: :collection
    end
  end
  # FIXME: 検索にreceivableを利用するようになれば削除
  resources :receivable_searches, :only => [:index]

  namespace :receivables do
    resources :discounts do
      get :search, on: :collection
      get :result, on: :collection
      post :select, on: :collection
      post :confirm, on: :collection
      post :update_all, on: :collection
    end
    resources :transfers do
      get :select, on: :collection
      post :search, on: :collection
      get :result, on: :collection
      post :confirm, on: :collection
      post :update_all, on: :collection
      get :trader_search, on: :collection
      get :company_bank_search, on: :collection
    end
    get "dealing_choice/regist", :to => "dealing_choice#regist"
    get "dealing_choice/discounts", :to => "dealing_choice#discounts"
    get "dealing_choice/transfers", :to => "dealing_choice#transfers"
  end

  namespace :journals do
    resources :dealing_choice do
      get :select, on: :collection
    end
    resources :journal_data do
      get :search, on: :collection
      get :confirm, on: :collection
      post :output, on: :collection
    end
  end

  resources :payables
  resources :departments
  resources :approval_settings, :except => [:destroy, :create]
  resources :remarks
  resources :users
  resources :license_allotments
  resources :abridgments
  resources :management_items
  get '/menu_authorities/menu_option_collections'
  resources :menu_authorities
  get '/approvers/menu_collection'

  resources :approvers
  resources :traders do
    get :edit_or_delete, on: :collection
    get :site, on: :collection
    get :search, on: :collection
  end
  resources :traders
  resources :slip_divisions
  resources :accounts
  resources :sub_accounts
  resources :analysis_divisions
  resources :analysis_items
  resources :operating_divisions
  resources :operating_division_settings
  resources :operating_items
  resources :receipts
  resources :date_bank_spreadsheets

  get 'default_payable_sites/make_trader_site_modal', to: 'default_payable_sites#make_trader_site_modal'
  get  'default_payable_sites', to: 'default_payable_sites#index'
  post 'default_payable_sites', to: 'default_payable_sites#update'

  get 'date_bank_choice', to: 'date_bank_choice#index'

  resources :use_accounts

  namespace :admin do
    devise_for :administrators, :path => "/", :skip => [:confirmations],
      :path_names => {:sign_in => 'login', :sign_out => 'logout', :registration => "profile", :sign_up => 'no_sign_up'}

    root :to => 'tops#show'
    resource :top, only: [:show]
    resources :products
    resources :management_divisions
    resources :companies do
      resource :user
      resources :licenses
    end
    resources :recording_institutions
    resources :banks, only: [:new, :create]
    get '/financial_institutions', :to => 'financial_institutions#index'
    post '/financial_institutions/import', :to => 'financial_institutions#import'
    resource  :banks
    resources :branches
    resources :menus
    resources :state_codes
    resources :administrators
    resources :recording_institutions
    resources :business_divisions
    resources :bank_holidays
    resources :stamp_taxes
    resources :tax_divisions
    resources :tax_rates
    resources :infos
  end

end
