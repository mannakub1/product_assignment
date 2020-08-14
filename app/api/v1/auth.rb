module V1
  class Auth < Grape::API

    resource :auth do
     
      params do
        requires :auth_token,   type: String
        requires :access_token, type: String
      end
      get :facebook do
        Auth::Facebook.new.call(permitted_params[:auth_token], permitted_params[:access_token])
      end

      params do
        requires :auth_token,   type: String
      end
      get :google do
        Auth::Google.new.call(permitted_params[:auth_token])
      end
      
    end
  end
end