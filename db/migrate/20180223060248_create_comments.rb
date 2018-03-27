class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user,      foreign_key: true
      t.references :kickspost, foreign_key: true
      t.references :reply,     index: true
      t.text       :content

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:user_id, :kickspost_id, :created_at]
  end
end
