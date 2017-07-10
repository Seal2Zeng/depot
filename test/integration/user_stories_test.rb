require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  
  fixtures :products
  include ActiveJob::TestHelper
  
  # test "the truth" do
  #   assert true
  # end
  test "buying a product" do
    
    start_order_count = Order.count
    ruby_book = products(:ruby)
  
    get "/"
    assert_response :success
    assert_select 'h1', 'Your Pragmatic Catalog'
    
    post '/line_items', params: {product_id: ruby_book.id}, xhr: true
    assert_response :success
    
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product
    
    get "/orders/new"
    assert_response :success
    assert_select 'legend', 'Please Enter Your Details'
    
    perform_enqueued_jobs do
      post "/orders", params: {
        order: {
          name: "Hao Zeng",
          address: "123 The Street",
          email: "hao.zeng@activenetwork.com",
          pay_type_id: 1
        }
      }
      follow_redirect!
    
      assert_response :success
      assert_select 'h1', 'Your Pragmatic Catalog'
      cart = Cart.find(session[:cart_id])
      assert_equal 0, cart.line_items.size
    
      assert_equal start_order_count + 1, Order.count
      order = Order.last
    
      assert_equal "Hao Zeng", order.name
      assert_equal "123 The Street",  order.address
      assert_equal "hao.zeng@activenetwork.com", order.email
      assert_equal "CHECK", order.pay_type.name
    
      assert_equal 1, order.line_items.size
      line_items = order.line_items[0]
      assert_equal ruby_book, line_items.product
    
      mail = ActionMailer::Base.deliveries.last
      assert_equal ["hao.zeng@activenetwork.com"], mail.to
      assert_equal 'Hao Zeng <depot@example.com>', mail[:from].value
      assert_equal "Pragmatic Store Order Confirmation", mail.subject
    end
  end
  
  test "should mail the admin when error occurs" do
    perform_enqueued_jobs do
      get "/carts/wibble" 
      assert_response :redirect  # should redirect to...
      assert_redirected_to store_index_url       # ...store index


      mail = ActionMailer::Base.deliveries.last
      assert_equal ["846190988@qq.com"], mail.to  ## replace mail id
      assert_equal "Depot Monitor <depot@example.com>", mail[:from].value  ## replace contact name/mail id
      assert_equal "Depot Exception Warning", mail.subject
    end
  end
  
  test "should fail on access of sensitive data" do
    
    delete '/logout'
    
    get '/products'
    follow_redirect!
    assert_response :success
    assert_equal '/login', path
    
  end
  
end
