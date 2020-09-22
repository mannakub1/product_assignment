module V1::Entities
  class Users < Grape::Entity
    expose :retirement, as: :retirement_data
    expose (:version_accept_term) do |model, options| 
      accept_term = model.accept_term
      number      = nil
      if accept_term.present?
        number =  accept_term["versions"].last["number"]
      end

      number
    end
  end
end
