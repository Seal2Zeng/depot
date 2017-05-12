class StoreController < ApplicationController
  def index
    @count = increment_counter
    @show_message = "You've been here #{@count} times" if @count > 5
    @products = Product.order(:title)
  end
  
  def increment_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
  
end
