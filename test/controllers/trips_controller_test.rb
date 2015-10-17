require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  setup do
    @trip = trips(:trip_one)
    sign_in users(:user_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    trips = assigns(:trips_pend)
    url = assigns(:url)
    assert_not_nil trips
    assert trips.count>0, "It should be able to see more one trip"
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip" do
    assert_difference('Trip.count') do
      post :create, trip: {
        :name=>"Testing name",
        :description=>"Mega long description",
        :who=>"Who's flying",
        :date_from=>Date.new,
        :date_to=>Date.new,
        :destination=>"Madrid"
      }
    end
    assert_redirected_to trips_path

  end

  test "should get edit" do
    get :edit, id: @trip
    assert_response :success
  end

  test "should update trip" do
    patch :update, id: @trip, trip: {
      :name=>"Testing name 2",
      :description=>"Mega long description",
      :who=>"Who's flying",
      :date_from=>Date.new,
      :date_to=>Date.new,
      :destination=>"Madrid"
    }

    assert_redirected_to trips_path
    assert 'Trip was successfully updated.',  flash[:notice]

  end

  test "should destroy trip" do
    assert_difference('Trip.count', -1) do
      delete :destroy, id: @trip
    end

    assert_redirected_to trips_path
  end

  test "should not be able to see if signed out" do
    sign_out users(:user_one)
    get :index
    assert_redirected_to new_user_session_path
  end

  test "shouldn't see any trips" do
    sign_out users(:user_one)
    sign_in users(:user_two)
    get :index
    assert_response :success
    trips= assigns(:trips_pend)
    assert_not_nil trips
    assert trips.count==0, "It should only see its own trips"
  end
end
