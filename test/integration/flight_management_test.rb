require 'test_helper'

class FlightManagementTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :trips
  fixtures :reservations
  fixtures :flights

  setup do
    sign_in users(:user_one)
    assert page.has_content?("List of trips")
    @trip=trips(:trip_one)
    @reserve=reservations(:reservation_one)
    @flight1=flights(:flight_one)
    @flight2=flights(:flight_two)
    @flight3=flights(:flight_three)
    @flight4=flights(:flight_four)
  end

  test "go to list, select trip, view flights" do
    assert page.has_content?(@trip.name), "It should show the first trip "+@trip.name
    click_on @trip.name

    assert page.has_content?(@reserve.code), "It should show the reserve code "+@reserve.code
    assert page.has_content?(@flight1.code), "It should show the code for the first flight "+@flight1.code
    assert page.has_content?(@flight2.code), "It should show the code for the first flight "+@flight2.code
    assert_match /FC4321.*FC1234/m, page.body, "Should show most recent flight first"
  end

  test "go to list, select trip, add flight to reservation" do
    click_on @trip.name
    #save_and_open_page
    click_on "New Flight"
    fill_in "flight_company", :with =>"British Airways"
    fill_in "flight_code", :with =>"MEGASUPERCODE"
    fill_in "flight_datetime_from", :with =>"13/03/2014"
    fill_in "flight_datetime_to", :with =>"13/04/2014"

    fill_in "flight_terminal_from", :with =>"London T5"
    fill_in "flight_terminal_to", :with =>"Madrid 4S"

    click_on "Create Flight"
#save_and_open_page
    assert page.has_content?("Flight was successfully created.")
    assert page.has_content?(@flight1.code), "It should show the old flight code "+@flight1.code
    assert page.has_content?(@flight2.code), "It should show the old flight code "+@flight2.code
    assert page.has_content?("MEGASUPERCODE"), "It should show the new flight code MEGASUPERCODE"
  end

  test "go to list, select trip, select flight" do
    click_on @trip.name
    click_on @flight1.code
    assert page.has_content?("Editing flight")
    assert_not page.has_content?("Show")
    click_on "Trip"
    assert page.has_content?("Editing trip")
  end
  test "Time values appear up to the minute (no secs)" do
    click_on @trip.name
    assert page.has_content?("2014-03-13 08:05")
    assert_not page.has_content?("2014-03-13 08:05:")
  end
end
