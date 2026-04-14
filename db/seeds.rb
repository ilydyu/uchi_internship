# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

school = School.create()
school_classes = []

10.times do
  school_class = SchoolClass.create(number: Faker::Number.between(from: 1, to: 400), letter: Faker::Types.character, students_count: 0, school: school)
  school_classes.push(school_class)
end

20.times do
  school_class = school_classes[rand(school_classes.length - 1)]
  student = Student.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, surname: Faker::Name.last_name, school: school, school_class: school_class)

  TokenService.generate_for(student)
  student.save!
end
