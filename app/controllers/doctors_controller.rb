class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
  end

  def destroy
    DoctorPatient.destroy(DoctorPatient.helper(params[:id], params[:patient_id]))
    redirect_to "/doctors/#{params[:id]}"
  end
end
