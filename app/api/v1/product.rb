module V1
  class Product < Grape::API
    resource :products do


      params do
        optional :page, type: Integer, default: 1
        optional :limit, type: Integer, default: 10
      end
      get do
       ::Product::Get.new.perform(params[:page], params[:limit])

      end

      params do
        optional :url, type: String, default: 'https://www.mercular.com/computers-accessories/computer-monitors?min_price=&max_price=&attribute_option%5B%5D=PANEL_TYPE%2FIPS&attribute_option%5B%5D=MONITOR_SCREEN_SIZE%2F241t280&attribute_option%5B%5D=MONITOR_REFRESH_RATE%2F75Hz&attribute_option%5B%5D=MONITOR_REFRESH_RATE%2F144Hz'
      end
      post :fetch do
        present :status, ::Product::Fetch.new.perform(params[:url])
      end
    end
  end

end