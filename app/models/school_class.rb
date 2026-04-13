class SchoolClass < ApplicationRecord
  self.table_name = 'classes'

  belongs_to :school
  has_many :students, foreign_key: 'class_id' 
end
