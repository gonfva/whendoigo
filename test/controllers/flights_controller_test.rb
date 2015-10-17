require 'test_helper'

class FlightsControllerTest < ActionController::TestCase
  setup do
    @flight = flights(:flight_one)
    sign_in users(:user_one)
  end

  test "should get index" do
    get :index,:trip_id=>1, :reservation_id=>1
    assert_response :success
    assert_not_nil assigns(:flights)
  end

  test "should get new" do
    get :new,:trip_id=>1, :reservation_id=>1
    assert_response :success
  end

  test "should create flight" do
    assert_difference('Flight.count') do
      post :create, :trip_id=>1, :reservation_id=>1, flight: {
        :company=>"British Airways",
        :code=>"ABCD1234",
        :terminal_from=>"Madrid",
        :terminal_to=>"London",
        :datetime_from=>Date.new,
        :datetime_to=>Date.new
      }
    end

    assert_redirected_to edit_trip_path(1)
  end


  test "should get edit" do
    get :edit,:trip_id=>1, :reservation_id=>1, id: @flight
    assert_response :success
  end

  test "should update flight" do
    patch :update,:trip_id=>1, :reservation_id=>1, id: @flight, flight: {
      :company=>"British Airways",
      :code=>"ABCD1234",
      :terminal_from=>"Madrid",
      :terminal_to=>"London",
      :datetime_from=>Date.new,
      :datetime_to=>Date.new
    }
    assert_redirected_to edit_trip_path(1)
  end

  test "should destroy flight" do
    assert_difference('Flight.count', -1) do
      delete :destroy,:trip_id=>1, :reservation_id=>1, id: @flight
    end

    assert_redirected_to trip_reservation_path(1,1)
  end

  test "should not be able to see if signed out" do
    sign_out users(:user_one)
    get :index,:trip_id=>1, :reservation_id=>1
    assert_redirected_to new_user_session_path
  end
end

