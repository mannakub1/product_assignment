module V1
  class Root < Grape::API
    mount Auth
    mount Users
  end
end