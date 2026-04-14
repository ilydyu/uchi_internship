class CreateStudents < ActiveRecord::Migration[8.1]
 def change
  create_table :students do |t|
    t.string :first_name
    t.string :last_name
    t.string :surname
    t.belongs_to :class
    t.belongs_to :school
    t.string :token_digest

    t.timestamps
  end

    add_index :students, :token_digest, unique: true
 end
end
