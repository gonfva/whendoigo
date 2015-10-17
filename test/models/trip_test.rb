require 'test_helper'

class TripTest < ActiveSupport::TestCase
fixtures :trips
fixtures :reservations
fixtures :flights
  test "We can create trips" do
    trip=Trip.new
    trip.name="Testing name"
    trip.description="Mega long description"
    trip.who="Who's flying"
    trip.date_from=Date.new
    trip.date_to=Date.new
    trip.destination="Madrid"
    trip.user=users(:user_one)
    assert trip.save
  end
  test "We cannot create trips without name" do
    trip=Trip.new
    assert !trip.save
  end
  test "We cannot create trips without user" do
    trip=Trip.new
    trip.name="New trip"
    assert !trip.save
  end
  test "We cannot create trips with wrong dates" do
    trip=Trip.new
    trip.name="Testing name"
    trip.description="Mega long description"
    trip.who="Who's flying"
    trip.date_from="This is not a correct date!"
    trip.date_to="This is not a correct date!"
    trip.destination="Madrid"
    trip.user=users(:user_one)
    assert_not trip.save
  end
  test "We see flights directly" do

    trip=trips(:trip_three)
    assert trip.flights.count==2
    assert_equal trip.flights[1].datetime_from.to_date,Date.today.weeks_since(1)
  end
end
