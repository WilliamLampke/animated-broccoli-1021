require 'rails_helper'

RSpec.describe 'Hospital Show' do
  before :each do
    @hospital1 = Hospital.create!(name: 'Greys Anatomy')
    @hospital2 = Hospital.create!(name: 'fake hospital')

    @doctor1 = Doctor.create!(name: 'doc1', specialty: 'eyes', university: 'unc', hospital_id: @hospital1.id)
    @doctor2 = Doctor.create!(name: 'doc2', specialty: 'cancer treatment', university: 'havard',
                              hospital_id: @hospital1.id)
    @doctor3 = Doctor.create!(name: 'doc3', specialty: 'brain surgery', university: 'yale',
                              hospital_id: @hospital1.id)

    @doctor4 = Doctor.create!(name: 'fakedoc', specialty: 'fake', university: 'mit', hospital_id: @hospital2.id)

    @patient1 = Patient.create!(name: 'doug', age: 65)
    @patient2 = Patient.create!(name: 'carol', age: 25)
    @patient3 = Patient.create!(name: 'bob', age: 45)

    @patient4 = Patient.create!(name: 'adam', age: 135)

    @dp1 = DoctorPatient.create!(doctor_id: @doctor1.id, patient_id: @patient1.id)
    @dp2 = DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
    @dp3 = DoctorPatient.create!(doctor_id: @doctor3.id, patient_id: @patient3.id)

    @dp4 = DoctorPatient.create!(doctor_id: @doctor4.id, patient_id: @patient4.id)
  end
  describe 'hospital show' do
    it "I see the hospital's name
    And I see the names of all doctors that work at this hospital,
    And next to each doctor I see the number of patients associated with the doctor,
    And I see the list of doctors is ordered from most number of patients to least number of patients
    (Doctor patient counts should be a single query)" do
      @dp5 = DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient1.id)
      @dp6 = DoctorPatient.create!(doctor_id: @doctor3.id, patient_id: @patient2.id)
      @dp7 = DoctorPatient.create!(doctor_id: @doctor3.id, patient_id: @patient1.id)
      visit "/hospitals/#{@hospital1.id}"
      expect(@doctor3.name).to appear_before(@doctor2.name)
      expect(@doctor2.name).to appear_before(@doctor1.name)
      expect(page).to have_content('Patient Count: 3')
      expect(page).to have_content('Patient Count: 2')
      expect(page).to have_content('Patient Count: 1')
    end
  end
end
