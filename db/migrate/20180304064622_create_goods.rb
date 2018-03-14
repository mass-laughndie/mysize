class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.references :user, foreign_key: true
      t.references :post, polymorphic: true, index: true

      t.timestamps
    end
    add_index :goods, [:user_id, :created_at]
    add_index :goods, [:user_id, :post_id, :post_type], unique: true
  end
end
