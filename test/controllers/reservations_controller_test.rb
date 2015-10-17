require 'test_helper'

class ReservationsControllerTest < ActionController::TestCase
  setup do
    @reservation = reservations(:reservation_one)
    sign_in users(:user_one)
  end

  test "should get index" do
    get :index,:trip_id=> 1
    assert_response :success
    assert_not_nil assigns(:reservations)
  end

  test "should get new" do
    get :new,:trip_id=> 1
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post :create,:trip_id=> 1, reservation: {
        :company=>"Iberia",
        :code=>"CodeIberia"
      }
    end

    assert_redirected_to edit_trip_path(1)
    saved_object=assigns(:reservation)
    assert saved_object.company=="Iberia"
    assert saved_object.code=="CodeIberia"

  end

  test "should get edit" do
    get :edit ,:trip_id=> 1, id: @reservation
    assert_response :success
  end

  test "should update reservation" do
    patch :update,:trip_id=> 1, id: @reservation, reservation: {
      :company=>"Iberia",
      :code=>"Iberia"
    }
    assert_redirected_to edit_trip_path(1)
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete :destroy, :trip_id=> 1, id: @reservation
    end

    assert_redirected_to trip_path(1)
  end

  test "should not be able to see if signed out" do
    sign_out users(:user_one)
    get :index,:trip_id=> 1
    assert_redirected_to new_user_session_path
  end
end
