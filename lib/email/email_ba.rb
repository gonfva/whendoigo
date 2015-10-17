  def process_ba
    trip=Trip.new
    trip.name="British AirWays reserve with code "+reserve_code
    trip.place_from
    trip.place_to
    trip.date_from
    trip.date_to
    trip.who
    trip.save!
  end

