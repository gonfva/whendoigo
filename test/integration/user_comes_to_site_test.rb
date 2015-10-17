require 'test_helper'

class UserComesToSiteTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "browse unregistered" do
    log_out
    visit "/"
    assert page.has_content?("Whendoigo")
    assert page.has_content?("Your travels in one place")
    click_on "About"
    assert page.has_content?("Gonzalo Fernandez-Victorio")
  end
  test "go to index, then login" do
    sign_in users(:user_one)
    assert page.has_content?("Signed in successfully.")
    assert page.has_content?("List of trips")
  end

  test "go to index, then register" do
    log_out
    visit "/"
    first(:link,"Sign up free").click
    assert page.has_content?("Sign up")
    assert page.has_content?("You've read and accept our terms and conditions")
    fill_in "user_email", :with => "testing@example.com"
    fill_in "user_password", :with =>"12345678"
    fill_in "user_password_confirmation", :with =>"12345678"
    check "user_terms"
    click_on "signup"
    assert page.has_content?("Thank you for registering")
  end


end
