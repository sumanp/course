class User < ApplicationRecord
  has_many :enrollments_as_student, class_name: 'Enrollment', foreign_key: 'user_id'
  has_many :enrollments_as_teacher, class_name: 'Enrollment', foreign_key: 'teacher_id'
  has_many :enrolled_programs_as_student, through: :enrollments_as_student, source: :program
  has_many :enrolled_programs_as_teacher, through: :enrollments_as_teacher, source: :program
  has_many :teachers, through: :enrollments, source: :teacher

  enum :kind, [:student, :teacher, :student_teacher]

  def self.classmates(user)
    where.not(id: user.id).joins(:enrollments_as_student).where(enrollments: { program_id: user.enrolled_programs_as_student.pluck(:id) })
  end
end
