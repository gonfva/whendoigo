class CreatePendingEmails < ActiveRecord::Migration
  def change
    create_table :pending_emails do |t|
      t.text :event
      t.boolean :processed, :default=>false
      t.boolean :correct, :default=>false
      t.references :user, index: true

      t.timestamps
    end
  end
end

