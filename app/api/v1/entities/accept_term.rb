module V1::Entities
  class AcceptTerm < Grape::Entity
    expose :number, as: :version
  end
end

