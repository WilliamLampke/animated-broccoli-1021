require 'rails_helper'

RSpec.describe Patient do
  it { should have_many(:doctor_patients) }
  it { should have_many(:doctors).through(:doctor_patients) }
  before :each do
    @hospital1 = Hospital.create!(name: 'Greys Anatomy')
    @hospital2 = Hospital.create!(name: 'fake hospital')

    @doctor1 = Doctor.create!(name: 'doc1', specialty: 'eyes', university: 'unc', hospital_id: @hospital1.id)
    @doctor2 = Doctor.create!(name: 'doc2', specialty: 'cancer treatment', university: 'havard',
                              hospital_id: @hospital1.id)
    @doctor3 = Doctor.create!(name: 'doc3', specialty: 'brain surgery', university: 'yale', hospital_id: @hospital1.id)

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
  describe '#adults' do
    it 'returns patients over 18 and sorted alphabetially' do
      patient5 = Patient.create!(name: 'ababy', age: 1)
      expect(Patient.adults).to eq([@patient4, @patient3, @patient2, @patient1])
    end
  end
end
