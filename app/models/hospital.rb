class Hospital < ApplicationRecord
  has_many :doctors
  has_many :patients, through: :doctor_patients, through: :doctors
  def most_to_least
    doctors
      .joins(:patients)
      .group(:id)
      .select('doctors.name, count(patients) AS patient_count')
      .order(patient_count: :desc)
  end
end
