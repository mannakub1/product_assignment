module V1::Entities
  class Users < Grape::Entity
   expose :id
   expose :email
  end
end
