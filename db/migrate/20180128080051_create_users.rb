class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :email
      t.string    :mysize_id
      t.string    :password_digest
      t.string    :image
      t.float     :size
      t.string    :content
      t.string    :remember_digest
      t.boolean   :admin,               default: false
      t.string    :uid
      t.string    :provider
      t.string    :reset_digest
      t.string    :e_token
      t.datetime  :reset_sent_at

      t.timestamps
    end
    add_index :users, :mysize_id,       unique: true
    add_index :users, :email,           unique: true
  end
end
