module V1
  class Root < Grape::API
    mount V1::Users => '/users'
  end
end