class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :surname 
      t.belongs_to :class_id
      t.belongs_to :school_id

      t.timestamps
    end
  end
end
