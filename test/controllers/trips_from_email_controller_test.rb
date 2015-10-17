require 'test_helper'

class TripsFromEmailControllerTest < ActionController::TestCase
  fixtures :users
  test "we can process incoming email" do
    mandrillapp=File.read("test/fixtures/email/mandrill.post")
    ENV["MAIL_PASSWORD"]="TestingApiKey"
    assert_difference('PendingEmail.count') do
      post :new_message, :mandrill_events=>mandrillapp, :mandrill_key=>ENV["MAIL_PASSWORD"], "CONTENT_TYPE" => 'application/json'
    end
    result=JSON.parse(@response.body)
    assert :success
    assert result.count==2
    expected=[["user1@test.eu","This is an example inbound message."],nil]
    assert expected==result, "Expected "+expected.to_s+" and obtained "+result.to_s
    #second time no more users emails
    assert_no_difference('PendingEmail.count') do
      post :new_message, :mandrill_events=>mandrillapp, :mandrill_key=>ENV["MAIL_PASSWORD"], "CONTENT_TYPE" => 'application/json'
    end
    assert :success
    result=JSON.parse(@response.body)
    assert expected==result, "Expected "+expected.to_s+" and obtained "+result.to_s
  end
  test "authentication" do
    mandrillapp=File.read("test/fixtures/email/mandrill.post")
    ENV["MAIL_PASSWORD"]="TestingApiKey"
    post :new_message, :mandrill_events=>mandrillapp, :mandrill_key=>"wrongkey", "CONTENT_TYPE" => 'application/json'
    result=JSON.parse(@response.body)
    assert :error
    assert result["errors"]== "Unauthenticated"
  end
  test "empty data" do
    mandrillapp=File.read("test/fixtures/email/mandrill.post")
    ENV["MAIL_PASSWORD"]="TestingApiKey"
    post :new_message, :mandrill_key=>ENV["MAIL_PASSWORD"], "CONTENT_TYPE" => 'application/json'
    result=JSON.parse(@response.body)
    assert :error
    assert result["errors"]== "No events"
  end
  test "head" do
    ENV["MAIL_PASSWORD"]="TestingApiKey"
    head :new_message, :mandrill_key=>ENV["MAIL_PASSWORD"], "CONTENT_TYPE" => 'application/json'
    assert :ok
  end
#myobject.send(:method_name, args)
end

