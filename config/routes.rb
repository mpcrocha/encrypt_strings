Rails.application.routes.draw do
  resources :encrypted_strings, param: :token
  resource :data_encrypting_keys do
    get 'status', to: 'data_encrypting_keys#status'
    post 'rotate', to: 'data_encrypting_keys#rotate'
  end
end
