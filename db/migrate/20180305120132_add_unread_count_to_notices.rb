class AddUnreadCountToNotices < ActiveRecord::Migration[5.1]
  def change
    add_column :notices, :unread_count, :integer, default: 1
  end
end
