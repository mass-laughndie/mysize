class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.integer :gooder_id
      t.integer :gooded_id
      t.references :post, polymorphic: true, index: true

      t.timestamps
    end
    add_index :goods, :gooder_id
    add_index :goods, :gooded_id
    add_index :goods, [:gooder_id, :post_id, :post_type], unique: true
  end
end
