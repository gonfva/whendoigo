class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :company
      t.string :code
      t.integer :price_number
      t.string :currency
      t.references :trip, index: true

      t.timestamps
    end
  end
end
