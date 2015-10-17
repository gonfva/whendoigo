class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # GET /trips
  # GET /trips.json
  def index
    @trips_current = Trip.current.where(user: current_user).ordered
    @trips_pend = Trip.pending.where(user: current_user).ordered
    @trips_old = Trip.old.where(user: current_user).ordered
    @url_calendar="/calendar/"+current_user.email+"/"+current_user.authentication_token + ".ics"
    @url_share="/calendar/"+current_user.email+"/"+current_user.authentication_token + ".html"
  end

  # GET /trips/new
  def new
    @pending=PendingEmail.where(:user=>current_user, :processed=>false)
    @trip = Trip.new
    @trip.date_from=DateTime.now.strftime("%Y-%m-%d")
    @trip.date_to=DateTime.now.strftime("%Y-%m-%d")
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    @trip.user=current_user
    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }

      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      @trip.user=current_user
      if @trip.update(trip_params)
        format.html { redirect_to trips_path, notice: 'Trip was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params[:trip].permit(:name,:description,:who,:date_from,:date_to,:destination)
    end
end
