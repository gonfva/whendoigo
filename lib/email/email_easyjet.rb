  def process_easyjet
    trip=Trip.new
    trip.name="Easyjet reserve with code "+reserve_code
    trip.place_from
    trip.place_to
    trip.date_from
    trip.date_to
    trip.who
    trip.save!
  end

