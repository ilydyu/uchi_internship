class Student < ApplicationRecord
 belongs_to :school_class, foreign_key: "class_id", counter_cache: true
 belongs_to :school
end
