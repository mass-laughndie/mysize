class AddColorToKicksposts < ActiveRecord::Migration[5.1]
  def change
    add_column :kicksposts, :color, :string
    add_column :kicksposts, :brand, :string
    
    add_index  :kicksposts, :color
    add_index  :kicksposts, :brand
    add_index  :kicksposts, :title
  end
end
