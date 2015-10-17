require 'tripit'


class ExportTripitController < ApplicationController
  #skip_before_filter :authenticate_user!, :only => [:authorized]


  def index
    server=Whendoigo3::Application.config.tripit_callbackserver
    redirect_to tripit_authorize_path and return if session[:authorized]=="true"
    begin
      request_token = get_request_token
      redirect_to "https://www.tripit.com/oauth/authorize?oauth_token=#{request_token.token}&oauth_callback=http://#{server}/tripit_authorize" and return
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
      session[:authorized]="false"
      redirect_to trips_path, alert: 'There was a problem trying to get authentication.'
    end
  end

  def authorized
    begin
      if session[:authorized]=="true"
        @authorized_token_secret=session[:tripit_auth_secret]
        @authorized_token=session[:tripit_auth]
      else
        get_authorized_token
        store_token
      end
      credential=get_credential(@authorized_token, @authorized_token_secret)
      Trip.where(user: current_user).each do |trip|
        export_trip trip,credential
      end
      redirect_to trips_path, notice: 'Trips successfully exported.'and return
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
      session[:authorized]="false"
      redirect_to trips_path, alert: 'There was a problem trying to process the export.'
    end
  end
private
  def get_request_token
    t=get_credential('','')
    request_token=t.get_request_token
    session[:tripit_token_secret]=request_token.token_secret
    session[:tripit_token]=request_token.token
    request_token
  end
  def get_authorized_token
    t=get_credential(session[:tripit_token], session[:tripit_token_secret])

    auth_token = t.get_access_token

    @authorized_token=auth_token.token
    @authorized_token_secret=auth_token.token_secret

  end
  def store_token
    session[:authorized]="true"
    session[:tripit_auth_secret]=@authorized_token_secret
    session[:tripit_auth]=@authorized_token
  end
  def export_trip (trip,credential)
    trip_xml = "<Request>#{trip.to_tripit}</Request>"
    #logger.info trip_xml
    #logger.info "token"+@authorized_token_secret +" - "+ @authorized_token
    result=credential.create(trip_xml)
    #logger.info result.to_xml.to_s
  end
  def get_credential(pub, secret)
    consumer_secret=Whendoigo3::Application.config.tripit_secret
    consumer_key=Whendoigo3::Application.config.tripit_pub
    api_url='https://api.tripit.com/'
    oauth_credential =TripIt::OAuthCredential.new(
        consumer_key, consumer_secret,
        pub,secret)
    TripIt::API.new(oauth_credential, api_url)
  end
end

