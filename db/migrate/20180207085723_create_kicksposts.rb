class CreateKicksposts < ActiveRecord::Migration[5.1]
  def change
    create_table :kicksposts do |t|
      t.text :content
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :kicksposts, [:user_id, :created_at]
  end
end
