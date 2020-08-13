module V1::Entities
  class UserEntity < Grape::Entity
    expose :id
    expose :name
  end
end
