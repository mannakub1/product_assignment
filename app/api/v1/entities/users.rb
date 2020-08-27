module V1::Entities
  class Users < Grape::Entity
   expose :retirement, as: :retirement_data
  end
end
