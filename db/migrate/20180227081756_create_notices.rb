class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.references :user,       foreign_key: true
      t.references :kind, polymorphic: true, index: true
      t.integer    :unread_count, default: 1

      t.timestamps
    end
    add_index :notices, [:user_id, :created_at]
    # add_index :notices, [:kind, :kind_id]
  end
end
