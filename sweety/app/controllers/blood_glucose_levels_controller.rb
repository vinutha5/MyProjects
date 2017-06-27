class BloodGlucoseLevelsController < ApplicationController
  before_action :set_blood_glucose_level, only: [:show, :edit, :update, :destroy]

  # GET /blood_glucose_levels
  def index
    @blood_glucose_levels = BloodGlucoseLevel.all
  end

  # GET /blood_glucose_levels/1
  def show
  end

  # GET /blood_glucose_levels/new
  def new
    @blood_glucose_level = BloodGlucoseLevel.new

  end

  # GET /blood_glucose_levels/1/edit
  def edit
  end

  # POST /blood_glucose_levels
  def create
      @from_date = Date.today.to_date.strftime("%Y-%m-%d")
      id = params[:blood_glucose_level][:patient_id]

      @patient_glucose_record = BloodGlucoseLevel.where(["patient_id=? and date(created_at)=?",id,@from_date])

      if @patient_glucose_record.count >= 4
        flash[:notice] = "Entry is over for the day to this patient"
        redirect_to :action => "new", notice: 'Entry is over for the day to this patient.'     
      else
        @blood_glucose_level = BloodGlucoseLevel.new(blood_glucose_level_params)
        if @blood_glucose_level.save
          redirect_to @blood_glucose_level, notice: 'Blood glucose level was successfully created.'
        else
          render :new
        end
      end
  end


  #Report View
  def reports

  end

  #Generate Reports
  def fetch_report
    session[:patient_id] = params[:patient_name] if session[:account] == "Doctor"
    date = params[:date].to_date
    report = params[:report]
    @daily_date = date.strftime("%Y-%m-%d")
    @month = date.strftime("%m")
    @begining = date.beginning_of_month.strftime("%Y-%m-%d")
    @patientname = Patient.find(session[:patient_id]).name
    @bloodgroup = Patient.find(session[:patient_id]).bloodgroup


    case report
    when  "Daily"
      @records =  BloodGlucoseLevel.where(["patient_id=? and date(created_at)=?", session[:patient_id] , @daily_date.to_date()])
    when "Monthly"
      @records =  BloodGlucoseLevel.where(["patient_id=? and extract(month from created_at)=?", session[:patient_id] , @month])
    else
      @records =  BloodGlucoseLevel.where(["created_at BETWEEN ? AND ?", @begining, @daily_date.to_date()])
    end

    render :layout=> false
  end

  # PATCH/PUT /blood_glucose_levels/1
  def update
    if @blood_glucose_level.update(blood_glucose_level_params)
      redirect_to @blood_glucose_level, notice: 'Blood glucose level was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blood_glucose_levels/1
  def destroy
    @blood_glucose_level.destroy
    redirect_to blood_glucose_levels_url, notice: 'Blood glucose level was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blood_glucose_level
      @blood_glucose_level = BloodGlucoseLevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blood_glucose_level_params
      params.require(:blood_glucose_level).permit(:patient_id, :glucose_level)
    end
end
