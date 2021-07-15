module V1
  class Root < Grape::API
    
    mount Product
  end
end