require 'test_helper'

class ReserveManagementTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :trips
  fixtures :reservations

  setup do
    sign_in users(:user_one)
    assert page.has_content?("List of trips")
    @trip=trips(:trip_one)
    @reserve=reservations(:reservation_one)
  end

  test "go to list, select trip, view reservations" do
    assert page.has_content?(@trip.name), "It should show the first trip "+@trip.name
    click_on @trip.name

    assert page.has_content?(@reserve.code), "It should show the reserve code "+@reserve.code


  end
  test "go to list, select trip, add reservation" do
    click_on @trip.name
    #save_and_open_page
    click_on "Add reservation"
    fill_in "reservation_company", :with =>"British Airways"
    fill_in "reservation_code", :with =>"MEGASUPERCODE"
    click_on "Create Reservation"
#save_and_open_page
    assert page.has_content?("Reservation was successfully created.")
    assert page.has_content?(@reserve.code), "It should show the old reserve code "+@reserve.code
    assert page.has_content?("MEGASUPERCODE"), "It should show the new reserve code MEGASUPERCODE"
  end
  test "go to list, select trip, select reservation" do
    click_on @trip.name
    click_on @reserve.company + " - "+@reserve.code
    #assert page.has_selector?('input#reservation_code', :text => @reserve.code)
    click_on "Trip"
    assert page.has_content?("Editing trip")
  end
end
