require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "h1","Whendoigo"
    assert_select "h2","Your travels in one place"
    assert_select "h2","It works for you"
    assert_select "h2","You own your data"
  end
end
