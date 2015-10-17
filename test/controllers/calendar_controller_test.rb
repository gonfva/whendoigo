require 'test_helper'

class CalendarControllerTest < ActionController::TestCase
  setup do
    @trip = trips(:trip_one)
    @user= users(:user_one)
  end

  test "should get ics" do
    assert_recognizes({:controller => 'calendar', :action => 'ics', "user_email"=>"*user_email", "user_token"=>"*user_token", "format"=>"ics"}, '/calendar/*user_email/*user_token.ics')
    get :ics, "user_email"=>@user.email, "user_token"=>@user.authentication_token, "format"=>"ics"
    assert_response :success
    assert response.headers['Content-Type']== "text/calendar"
  end

  test "should get html" do
    assert_recognizes({:controller => 'calendar', :action => 'ics', "user_email"=>"*user_email", "user_token"=>"*user_token", "format"=>"html"}, '/calendar/*user_email/*user_token.html')
    get :ics, "user_email"=>@user.email, "user_token"=>@user.authentication_token, "format"=>"html"
    assert_response :success
  end
end
