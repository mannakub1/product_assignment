module V1
  class Users < Grape::API
    get do
      # user = UserService::GetInfo.call()
      param1 = {

      }
      user   = { id: 1, name: 'GEN' }
      present :user, user, with: Entities::UserEntity
    end
  end
end