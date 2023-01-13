require 'rails_helper'

RSpec.describe 'Patients Index' do
    before :each do
        @hospital1 = Hospital.create!(name: 'Greys Anatomy')
        @hospital2 = Hospital.create!(name: 'fake hospital')
    
        @doctor1 = Doctor.create!(name: 'doc1', specialty: 'eyes', university: 'unc', hospital_id: @hospital1.id)
        @doctor2 = Doctor.create!(name: 'doc2', specialty: 'cancer treatment', university: 'havard', hospital_id: @hospital1.id)
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
      describe 'patients index' do
        it "I see the names of all adult patients (age is greater than 18),
        And I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)" do
            patient5 = Patient.create!(name: 'ababy', age: 1) 
            visit "/patients"
            expect("Name: adam").to appear_before("Name: bob")
            expect("Name: bob").to appear_before("Name: carol")
            expect("Name: carol").to appear_before("Name: doug")

            expect("135").to appear_before("45")
            expect("45").to appear_before("25")
            expect("25").to appear_before("65")
        end
      end
end