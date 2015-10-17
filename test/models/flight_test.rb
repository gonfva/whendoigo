require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  test "We can create flights" do
    flight=Flight.new
    flight.company="Iberia"
    flight.code="ABCD1234"
    flight.terminal_from="Madrid"
    flight.terminal_to="London"
    flight.datetime_from= Date.new
    flight.datetime_to= Date.new
    flight.reservation=reservations(:reservation_one)
    assert flight.save
  end
  test "All the fields are mandatory" do
    flight=Flight.new
    assert !flight.save
    flight.company="Iberia"
    assert !flight.save
    flight.code="ABCD1234"
    assert !flight.save
    flight.terminal_from="Madrid"
    assert !flight.save
    flight.terminal_to="London"
    assert !flight.save
    flight.datetime_from= Date.new
    assert !flight.save
    flight.datetime_to= Date.new
    assert !flight.save
    flight.reservation=reservations(:reservation_one)
    assert flight.save
  end
  test "We cannot create flight with wrong dates" do
    flight=Flight.new
    flight.company="Iberia"
    flight.code="ABCD1234"
    flight.terminal_from="Madrid"
    flight.terminal_to="London"
    flight.datetime_from= "This not a date!"
    flight.datetime_to= "This not a date!"
    flight.reservation=reservations(:reservation_one)
    assert_not flight.save
  end
end

