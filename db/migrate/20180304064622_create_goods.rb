class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.references :user, foreign_key: true
      t.integer    :kind_id
      t.string     :kind

      t.timestamps
    end
    add_index :goods, [:user_id, :created_at]
    add_index :goods, [:kind_id, :kind]
    add_index :goods, [:user_id, :kind_id, :kind], unique: true
  end
end
