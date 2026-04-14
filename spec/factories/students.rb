FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    surname { Faker::Name.last_name }
    school_class
    school

    trait :with_token do
      after(:create) do |student|
        token = TokenService.generate_for(student)

        student.save!

        student.define_singleton_method(:raw_token) { token }
      end
    end
  end
end
