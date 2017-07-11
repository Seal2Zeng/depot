class StoreController < ApplicationController
  
  skip_before_action :authorize
  
  include CurrentCart
  before_action :set_cart
  
  def index
    @count = increment_counter
    @show_message = "You've been here #{@count} times" if @count > 5
    
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
  
  def increment_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
  
end
