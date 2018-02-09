class AddIndexToUsersMysizeId < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :mysize_id, unique: true
    add_index :users, :email,     unique: true
  end
end
