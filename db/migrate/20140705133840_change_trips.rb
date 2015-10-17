class ChangeTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :place_from
    rename_column :trips, :place_to, :destination
    remove_column :reservations, :price_number
    remove_column :reservations, :currency
  end
end
