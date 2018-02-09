class AddImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string
    add_column :users, :shoe_size, :integer
    add_column :users, :profile_content, :string
  end
end
