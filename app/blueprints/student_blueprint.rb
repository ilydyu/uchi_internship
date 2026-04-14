class StudentBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name, :surname, :school_id, :class_id
end
