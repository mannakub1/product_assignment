module V1
  class Root < Grape::API
    mount Users
  end
end