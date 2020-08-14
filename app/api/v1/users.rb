module V1
  class Users < Grape::API

    resource :users do
     
      get do
        user = User::GetInfo.new.call
        present :user, user
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