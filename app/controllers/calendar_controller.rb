class CalendarController < ApplicationController
  skip_filter :authenticate_user!
  before_filter :authenticate_user_from_token!

  def ics
    respond_to do |format|
      format.ics {
        cal = get_ics_entries
        expires_in 1.hour, :public => false
        send_data(cal.export, :filename=>"mytrips.ics", :disposition=>"inline; filename=mycal.ics", :type=>"text/calendar")
      }
      format.html {
        @trips=Trip.pending.where(:user=>@current_user).ordered
        render layout: "no_header"
      }
    end
end
  def get_ics_entries
    @trips=Trip.where(user: @current_user)
    RiCal.Calendar do |cal|

      @trips.pending.each do |trip|
        cal.event do |event|
          event.summary=trip.name
          event.description= trip.description if trip.description
          event.dtstart= trip.date_from if trip.date_from
          event.dtend= trip.date_to + 1.day if trip.date_to
          event.location= trip.destination if trip.destination
          event.add_attendee trip.who if trip.who
        end
      end
    end

  end
  def authenticate_user_from_token!
    return if user_signed_in?
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    unless user && Devise.secure_compare(user.authentication_token, params[:user_token])
      raise "Unauthenticated"
    end
    @current_user=user
  end
end
