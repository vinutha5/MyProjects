class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create

    if params[:account][:type] == "Patient"
      @patient = Patient.new(:name=>params[:first_name]+params[:last_name],:address=>params[:address],:email=>params[:email],:phone=>params[:phone],:bloodgroup=>params[:patient][:bloodgroup])
      @patient.save
      @res = @patient.id
    else
      @doctor = Doctor.new(:name=>params[:first_name]+params[:last_name],:address=>params[:address],:email=>params[:email],:phone=>params[:phone])
      @doctor.save
      @res = @doctor.id
    end

    @user = User.new(:account_id=> @res,:username=>params[:username], :password=>params[:password],:account_type=>params[:account][:type])

    if @user.save
      redirect_to :action=>"login", notice: 'User was successfully created.'
    else
      redirect_to :action=>"login", notice: 'Error while registering the Patient/Doctor'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def login
    
  end

  def logout
    session.clear
    redirect_to :action=>"login"
  end

  def autheticate
    user = User.find_by username: params[:username]
    if user && user.password ==  params[:password]
      user    
      redirect_to :controller=>"home" , :action=>"home" 
      session[:username] = user.username
      if user.account_type == "Patient"
        session[:account] = "Patient"
        session[:patient_id] = user.account_id
      else
        session[:account] = "Doctor"
        session[:doctor_id] = user.account_id
      end
    else
      flash[:notice] = "Invalid Username or Password"
      redirect_to :action=>"login"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:account_id,:username, :password, :account_type)
    end
end
