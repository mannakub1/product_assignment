

class Product::Fetch < ApplicationService
  
  def perform(url)
    response = WebCrawler.process(url)
    "ok"
  end
end


class WebCrawler < Kimurai::Base
  @name = 'product'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  # Extract data
  def parse(response, url:, data: {})
  
    products = []  
    response.xpath("//div[@data-product]").each_with_index do |product, index|
      price            = "0"
      discountPrice    = "0"
      displayHertzType = nil

      no       = product.xpath("//@data-product")[index]&.text
      itemName = product.css('h3.product-name').css('a')[0]&.text&.squish
      imageUrl = product.css("img.img-responsive")[0]['src']
      priceAll = product.css("span.amount")

       itemName.split(" ").each do |name|
        if name.index('Hz') != nil
          displayHertzType = name 
        end
       end
        
      if priceAll.size == 2
        discountPrice, price = priceAll&.text&.squish.split(" ")  
      else
        price = priceAll&.text&.squish
      end
      
      # find or initialize object product
      product = Product.find_or_initialize_by(
        no: no        
      )
      product.itemName = itemName
      product.imageUrl = imageUrl
      product.price = price.gsub!(',','').to_f
      product.discountPrice = discountPrice.gsub!(',','').to_f
      product.displayHertzType = displayHertzType
      product.save!
      # Product.where(no: product.no).first_or_create
    end

  
  end
end