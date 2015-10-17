class TripsFromEmailController < ApplicationController
  include Mandrill::Rails::WebHookProcessor

  skip_before_filter :authenticate_user!
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :authenticate_mandrill!
  def new_message
    if request.head?
      head :ok and return
    end
  	events=params['mandrill_events']
    if events.nil?
      render :status=>:bad_request,:json => { :errors => "No events" } and return
    end
    result=parse_events(events)
    render :status => :ok, :json=> result.to_json

  end
  def import
    begin
      @pending=PendingEmail.where(:user=>current_user, :processed=>false).take
      redirect_to trips_path, alert: 'No pending emails.' and return unless @pending
      ImportFromEmail.import @pending.event
      @pending.processed=true
      @pending.save!
      redirect_to trips_path, notice: 'Trip was successfully created.' and return
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
      redirect_to new_trip_path, alert: 'There was a problem trying to process the import.'
    end
  end
  def delete
    @pending=PendingEmail.where(:user=>current_user, :processed=>false).take
    redirect_to trips_path, alert: 'No pending emails.' and return unless @pending
    @pending.processed=true
    @pending.save!
    redirect_to new_trip_path, notice: 'Message successfully deleted.'
  end
private
  def parse_events(events)
    JSON.parse(events).map do |raw_event|
      event = Mandrill::WebHook::EventDecorator[raw_event]
      from= event['msg']['from_email'].to_s
      to= event['msg']['email'].to_s
      user=check_security(from,to)
      if user
        add_event user, event
			  text_body = event['msg']['text'].to_s
        [user.email, text_body] if user
      else
        nil
      end
    end
  end
  def check_security (from, to)
    user=User.find_by_email(from)
    my_match=to.match(/trips(.*)@in.whendoigo.co.uk/)
    token=my_match[1]
    return nil unless user && user.authentication_token==token
    user
  end
  def add_event user, event
    PendingEmail.destroy_all(:user=>user, :processed=>false)
    pending=PendingEmail.new
    pending.user=user
    pending.event=event.to_s
    pending.save!
  end
  def authenticate_mandrill!
    if params['mandrill_key']!=ENV["MAIL_PASSWORD"]
      render :status => :forbidden,:json => { :errors => "Unauthenticated" } and return
    end
  end
end

