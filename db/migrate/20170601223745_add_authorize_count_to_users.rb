class AddAuthorizeCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :authorize_count, :integer, default: 0
  end
end
