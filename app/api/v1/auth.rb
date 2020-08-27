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
        present :auth_token, Auth::Google.new.call(permitted_params[:auth_token])
      end
      
    end
  end
end