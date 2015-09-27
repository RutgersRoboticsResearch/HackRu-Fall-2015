class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registered, :boolean, :null => false, :default => false
    add_column :users, :email_sent, :boolean, :null => false, :default => false
  end

end
