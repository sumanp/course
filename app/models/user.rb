class User < ApplicationRecord
  has_many :enrollments
  has_many :enrolled_programs, through: :enrollments, source: :program
  has_many :teachers, through: :enrollments, source: :teacher

  enum :kind, [:teacher, :student, :student_teacher]

  def self.classmates(user)
    where.not(id: user.id).joins(:enrollments).where(enrollments: { program_id: user.enrolled_programs.pluck(:id) })
  end
end
