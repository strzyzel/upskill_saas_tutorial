class ProfilesController < ApplicationController
  # GET to /users/:user_id/profile/new
  def new
    @profile = Profile.new
  end
  # POST to /users/:user_id/profile/new
  def create
    # Ensure that we have a user that is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to that specific user.
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description, :avatar)
    end
end