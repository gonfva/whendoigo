class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :company
      t.string :code
      t.string :terminal_from
      t.string :terminal_to
      t.datetime :datetime_from
      t.datetime :datetime_to
      t.references :reservation, index: true
      
      
      t.timestamps
    end
  end
end
