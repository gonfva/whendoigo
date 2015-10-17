module TripsHelper
  def get_table()
  end

  def trip_on_date(trips, week, weekday)
    d=get_date(week,weekday)
    trips.each do |trip|
      if trip.date_from <= d && (trip.date_to.nil? || trip.date_to >= d)
        return true
      end
    end
    return false
  end
  def flight_on_date(trips, week, weekday)
    d=get_date(week,weekday)
    trips.each do |trip|
      trip.flights.each do |flight|
        if flight.datetime_from.to_date==d
          return true
        end
      end
    end
    return false
  end
  def get_date(week, weekday)
    today=Date.today
    today.weeks_since(week).days_since(weekday-today.wday)
  end
  def write_header(today=Date.today)
    old_month = today.months_ago(1)
    content_tag(:tr) do
      concat content_tag(:th, " ", class: "calendar_header_column")
      (0..50).each do |w|
        name_month=" "
        new_date = today.weeks_since(w).end_of_week
        current_month = new_date.month
        if (current_month!= old_month)
          old_month=current_month
          name_month=new_date.strftime("%b")
        end
        concat content_tag(:th, name_month, class: "calendar_header_column")
      end
    end
  end
end
