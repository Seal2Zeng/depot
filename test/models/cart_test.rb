require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup

    @cart  = Cart.create

    @book_one = products(:one)

    @book_two  = products(:two)
    
    @book_ruby = products(:ruby)

  end

  test "add unique products" do

    @cart.add_product(@book_one).save!

    @cart.add_product(@book_ruby).save!

    assert_equal 2, @cart.line_items.size

    assert_equal @book_one.price + @book_ruby.price, @cart.total_price

  end
  
  test "add duplicate products" do

    @cart.add_product(@book_ruby).save!

    @cart.add_product(@book_ruby).save!

    assert_equal 1, @cart.line_items.size

    assert_equal 2, @cart.line_items.first.quantity

    assert_equal @book_ruby.price * 2, @cart.total_price
  end
  
end
