class CreateKicksposts < ActiveRecord::Migration[5.1]
  def change
    create_table :kicksposts do |t|
      t.references :user,       foreign_key: true
      t.text       :content
      t.string     :picture
      t.float      :size

      t.timestamps
    end
    add_index :kicksposts, [:user_id, :created_at]
  end
end
