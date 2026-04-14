FactoryBot.define do
  factory :school_class do
    number { Faker::Number.between(from: 1, to: 400) }
    letter { Faker::Types.character }
    students_count { 0 }
    school
  end
end
