require 'test_helper'

class TripsHelperTest < ActionView::TestCase
  fixtures :users
  fixtures :trips
  fixtures :reservations
  fixtures :flights
  test "Trip three does behave correctly" do
    trips_pend = Trip.pending.where(user: 1).ordered

    assert_not_nil trips_pend
    assert trips_pend.count>0
    assert trip_on_date(trips_pend, 1, Date.today.wday)
    assert !trip_on_date(trips_pend, 0, Date.today.wday)
    assert flight_on_date(trips_pend, 1, Date.today.wday)
    assert !flight_on_date(trips_pend, 0, Date.today.wday)
  end
  test "get_date works" do

    tday=get_date(0, Date.today.wday)
    assert tday==Date.today
    next_week=get_date(1, Date.today.wday)

    nw=Date.today.weeks_since(1)
    assert next_week==nw
  end
end
