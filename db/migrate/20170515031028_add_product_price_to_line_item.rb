class AddProductPriceToLineItem < ActiveRecord::Migration[5.1]
  
  def change

    add_column :line_items, :price, :decimal

    LineItem.all.each do |li|

      li.update_attribute :price, li.product.price

    end

  end
  
end
