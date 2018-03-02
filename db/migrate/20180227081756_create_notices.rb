class CreateNotices < ActiveRecord::Migration[5.1]
  def change
    create_table :notices do |t|
      t.string     :kind
      t.references :user,       foreign_key: true
      t.integer    :kind_id
      t.boolean    :read,       default: false

      t.timestamps
    end
    add_index :notices, [:user_id, :created_at]
  end
end
