module V1
  class Users < Grape::API

    resource :users do
      params do
        requires :user_id, type: String
      end
      get do
        user = User::GetInfo.new.call(permitted_params[:user_id])
        present :user, user, with: V1::Entities::Users
      end
      route_param :user_id do
        get do
          user = User::GetInfo.new.call(params[:user_id])
          present :user, user, with: V1::Entities::Users
        end
      end
    end
  end
end