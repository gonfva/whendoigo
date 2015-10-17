require 'test_helper'

class ExportToICalTest < ActionDispatch::IntegrationTest
  fixtures :users
  fixtures :trips


  test "go to list, view calendar" do
    user1=users(:user_one)
    sign_in user1
    url=find_link('Calendar')[:href]
    assert url == '/calendar/'+user1.email+'/'+user1.authentication_token+".ics"
    click_on("Calendar")
    assert page.response_headers['Content-Type']== "text/calendar"


  end
end
