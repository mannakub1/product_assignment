class Product::Get < ApplicationService

  def perform(page, limit)
    # query
    products = Product.order(:created_at)
   
    # pagination
    response = Kaminari.paginate_array(products).page(page).per(limit)

    {
      products:     response,
      page:         response.page(1).current_page,
      limit:        response.limit_value,
      total_page:   response.page(1).total_pages
    }
  end
end