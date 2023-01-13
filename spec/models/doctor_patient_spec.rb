require 'rails_helper'

RSpec.describe DoctorPatient do
  it {should belong_to :doctor}
  it {should belong_to :patient}
  before :each do
    @hospital1 = Hospital.create!(name: 'Greys Anatomy')
    @hospital2 = Hospital.create!(name: 'fake hospital')

    @doctor1 = Doctor.create!(name: 'doc1', specialty: 'eyes', university: 'unc', hospital_id: @hospital1.id)
    @doctor2 = Doctor.create!(name: 'doc2', specialty: 'cancer treatment', university: 'havard', hospital_id: @hospital1.id)
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
  describe '#helper' do
    it "finds a dp by doctor and patient id and returns a id" do
      expect(DoctorPatient.helper(@doctor1.id, @patient1.id)).to eq(@dp1.id)
    end
  end
end
