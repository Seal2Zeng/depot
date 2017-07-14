class AddLocaleToProduct < ActiveRecord::Migration[5.1]
  
  def self.up
    add_column :products, :locale, :string
  end
  
  def self.down
    remove_column :products, :locale
  end
  
end
