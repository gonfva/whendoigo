class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    @flights = Flight.all.order(:datetime_from=> :asc)
    @trip = Trip.find(params[:trip_id])
    @reservation =Reservation.find(params[:reservation_id])
  end


  # GET /flights/new
  def new
    @flight = Flight.new
    @trip = Trip.find(params[:trip_id])
    @reservation =Reservation.find(params[:reservation_id])
    @flight.company=@reservation.company
    @flight.datetime_from=@trip.date_from
    @flight.datetime_to=@trip.date_from
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)
      @trip = Trip.find(params[:trip_id])
      @reservation =Reservation.find(params[:reservation_id])
    respond_to do |format|
      @flight.reservation=@reservation
      if @flight.save
        format.html { redirect_to edit_trip_path(@trip), notice: 'Flight was successfully created.' }
        format.json { render action: 'show', status: :created, location: @flight }
      else
        format.html { render action: 'new' }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      @flight.reservation=@reservation
      if @flight.update(flight_params)
        format.html { redirect_to edit_trip_path(@trip), notice: 'Flight was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to trip_reservation_path(@trip,@reservation) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @trip = Trip.find(params[:trip_id])
      @reservation =Reservation.find(params[:reservation_id])
      @flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flight_params
      params[:flight].permit(:company,:code,:terminal_from,:terminal_to,:datetime_from,:datetime_to )
    end
end
