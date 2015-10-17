require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  test "We can create reservations" do
    reservation=Reservation.new
    reservation.company="Iberia"
    reservation.code="ABCD1234"
    reservation.trip=trips(:trip_one)
    assert reservation.save
  end
  test "We cannot create trips without company" do
    reservation=Reservation.new
    reservation.code="ABCD1234"
    reservation.trip=trips(:trip_one)
    assert !reservation.save
  end
  test "We cannot create trips without code" do
    reservation=Reservation.new
    reservation.company="Iberia"
    reservation.trip=trips(:trip_one)
    assert !reservation.save
  end

  test "We cannot create reservation without a trip" do
    reservation=Reservation.new
    reservation.company="Iberia"
    reservation.code="ABCD1234"
    assert !reservation.save
  end
end
