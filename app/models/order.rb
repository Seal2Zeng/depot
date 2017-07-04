class Order < ApplicationRecord
    
    has_many :line_items, dependent: :destroy
    belongs_to :pay_type
    include ActiveModel::Dirty
    
    #enum pay_type: {
    #    CHECK: 0, 
    #    CREDIT_CARD: 1, 
    #    PURCHASE_ORDER: 2
    #}

    validates :name, :address, :email, presence: true
    validates_inclusion_of :pay_type_id, :in => PayType.all.ids

    def add_line_items_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end

end