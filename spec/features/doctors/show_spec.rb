require 'rails_helper'

RSpec.describe 'Doctor Show' do
  before :each do
    @hospital1 = Hospital.create!(name: 'Greys Anatomy')
    @hospital2 = Hospital.create!(name: 'fake hospital')

    @doctor1 = Doctor.create!(name: 'doc1', specialty: 'eyes', university: 'unc', hospital_id: @hospital1.id)
    @doctor2 = Doctor.create!(name: 'doc2', specialty: 'cancer treatment', university: 'havard',
                              hospital_id: @hospital1.id)
    @doctor3 = Doctor.create!(name: 'doc3', specialty: 'brain surgery', university: 'yale', hospital_id: @hospital1.id)

    @doctor4 = Doctor.create!(name: 'fakedoc', specialty: 'fake', university: 'mit', hospital_id: @hospital2.id)

    @patient1 = Patient.create!(name: 'patient1', age: 65)
    @patient2 = Patient.create!(name: 'patient1', age: 25)
    @patient3 = Patient.create!(name: 'patient1', age: 45)

    @patient4 = Patient.create!(name: 'fakepatient', age: 135)

    @dp1 = DoctorPatient.create!(doctor_id: @doctor1.id, patient_id: @patient1.id)
    @dp2 = DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: @patient2.id)
    @dp3 = DoctorPatient.create!(doctor_id: @doctor3.id, patient_id: @patient3.id)

    @dp4 = DoctorPatient.create!(doctor_id: @doctor4.id, patient_id: @patient4.id)
  end
  describe 'doctor show' do
    it "I see all of that doctor's information including:
        - name
        - specialty
        - university where they got their doctorate
       And I see the name of the hospital where this doctor works
       And I see the names of all of the patients this doctor has" do
      visit "/doctors/#{@doctor1.id}"
      expect(page).to have_content(@doctor1.name)
      expect(page).to have_content(@doctor1.specialty)
      expect(page).to have_content(@doctor1.university)
      expect(page).to have_content(@doctor1.hospital.name)
      expect(page).to have_content(@patient1.name)
    end
  end
  describe '' do
    it "Then next to each patient's name, I see a button to remove that patient from that doctor's caseload
    When I click that button for one patient
    I'm brought back to the Doctor's show page
    And I no longer see that patient's name listed
    And when I visit a different doctor's show page that is caring for the same patient,
    Then I see that the patient is still on the other doctor's caseload" do
      patient5 = Patient.create!(name: 'deletepatient', age: 200)
      dp5 = DoctorPatient.create!(doctor_id: @doctor1.id, patient_id: patient5.id)
      dp6 = DoctorPatient.create!(doctor_id: @doctor2.id, patient_id: patient5.id)
      visit "/doctors/#{@doctor1.id}"
      expect(page).to have_content(patient5.name)
      click_on "Delete #{patient5.name}"
      expect(page).to_not have_content(patient5.name)
      visit "/doctors/#{@doctor2.id}"
      expect(page).to have_content(patient5.name)
    end
  end
end
