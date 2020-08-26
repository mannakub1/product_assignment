module V1
  class Users < Grape::API

    resource :users do
  
      params do
        # requires :a, type: Integer
        requires :retirement_data, type: Hash do
          requires :goal, type: Hash
          requires :salary, type: Hash
          requires :social_security, type: Hash
          requires :provident_fund, type: Hash
          requires :saving, type: Hash
          requires :post_retirment, type: Hash
        end
      end
      post do
        puts "== debug params ==="
        p permitted_params
        ApplicationService.init(headers)
      end
    end
  end
end