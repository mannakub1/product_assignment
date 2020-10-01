module V1
  class Auth < Grape::API

    resource :auth do
     
      params do
        requires :auth_token,   type: String
        # requires :access_token, type: String
      end
      get :facebook do
        user, auth_token = ::Auth::Facebook.new.call(permitted_params[:auth_token])
        present :user, user, with: Entities::Users
        present :auth_token, auth_token 
      end

      params do
        requires :auth_token,   type: String
      end
      get :google do
        user, auth_token = ::Auth::Google.new.call(permitted_params[:auth_token])
        present :user, user, with: Entities::Users
        present :auth_token, auth_token 
      end

      params do
        requires :auth_token,   type: String
        optional :first_name,   type: String
        optional :last_name,    type: String
        optional :email,        type: String
      end
      get :apple do
        user, auth_token = ::Auth::Apple.new.call(
          permitted_params[:auth_token],
          permitted_params[:first_name],
          permitted_params[:last_name],
          permitted_params[:email])
        present :user, user, with: Entities::Users
        present :auth_token, auth_token 
      end
      
    end
  end
end