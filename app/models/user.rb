class User < ApplicationRecord
  enum :kind, [:teacher, :student, :student_teacher]
end
