class DoctorPatient < ApplicationRecord
    belongs_to :doctor 
    belongs_to :patient 
    def self.helper(doc_id, pat_id)
        where(doctor_id: doc_id, patient_id: pat_id)
        .first
        .id
    end
end