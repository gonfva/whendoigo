class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.string :description
      t.string :who
      t.string :place_from
      t.string :place_to
      t.string :status
      t.date :date_from
      t.date :date_to
      t.references :user, index: true
      
      t.timestamps
    end
  end
end
