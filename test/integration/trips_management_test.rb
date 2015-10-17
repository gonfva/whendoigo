require 'test_helper'

class TripsManagementTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :trips

  test "should show no trips, create trip" do
    sign_in users(:user_two)
    assert page.has_content?("List of trips")
    #save_and_open_page
    assert page.has_content?("You don't have any pending trip"), "It should show there is no trips"
    click_on "Create a new trip"
    assert page.has_content?("New trip")
    fill_in "trip_name", :with =>"Easter trip"
    fill_in "trip_description", :with =>"This is a super description"
    fill_in "trip_who", :with =>"John Doe"
    fill_in "trip_date_from", :with =>"13/03/2014"
    fill_in "trip_date_to", :with =>"13/04/2014"

    fill_in "trip_destination", :with =>"Madrid"

    click_on "Create Trip"
#save_and_open_page
    assert page.has_content?("Trip was successfully created.")
    assert page.has_content?("List of trips")
    assert page.has_content?("Easter trip"), "There should be a trip created"

  end
  test "go to list, view trips" do
    sign_in users(:user_one)
    assert page.has_content?("List of trips")
    trip=trips(:trip_one)

    assert page.has_content?(trip.name), "It should show the first trip "+trip.name



  end

  test "go to list, view calendar" do
    user1=users(:user_one)
    sign_in user1
    assert page.has_content?("Calendar")
    url=find_link('Calendar')[:href]
    assert url == '/calendar/'+user1.email+'/'+user1.authentication_token+".ics"


  end
  test "assert order" do
    user1=users(:user_one)
    sign_in user1
    assert_match /Triptwo.*Tripone/m, page.body, "Should show most recent trip first"
  end
end
