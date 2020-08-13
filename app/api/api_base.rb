class ApiBase < Grape::API
  format :json

  mount V1::Root => 'api/v1'
end