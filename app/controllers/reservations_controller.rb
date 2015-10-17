class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @trip = Trip.find(params[:trip_id])
    @reservations = @trip.reservations
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @trip = Trip.find(params[:trip_id])
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @trip = Trip.find(params[:trip_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.trip=@trip

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to edit_trip_path(@trip), notice: 'Reservation was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      @reservation.trip=@trip
      if @reservation.update(reservation_params)
        format.html { redirect_to edit_trip_path(@trip), notice: 'Reservation was successfully updated.' }
      else
        format.html { render action: 'edit' }

      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to @trip }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @trip = Trip.find(params[:trip_id])
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params[:reservation].permit(:company, :code)
    end
end
