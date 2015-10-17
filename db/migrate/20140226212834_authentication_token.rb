class AuthenticationToken < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_index :users, :authentication_token,   :unique => true
    User.all.each do |user|
      user.save!
    end
  end
end

