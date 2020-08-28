module V1
  class Users < Grape::API

    resource :users do
  
      params do
        requires :retirement_data, type: Hash do
          requires :goal, type: Hash
          requires :salary, type: Hash
          requires :social_security, type: Hash
          requires :provident_fund, type: Hash
          requires :saving, type: Hash
          requires :post_retirement, type: Hash
        end
      end
      put :retirements do
        puts "=== debug headers ===="
        p headers
        present :user, User::Retirement.init(headers).call(permitted_params[:retirement_data]), with: Entities::Users
      end
    end
  end
end