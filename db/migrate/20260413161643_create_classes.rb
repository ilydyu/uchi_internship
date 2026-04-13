class CreateClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :classes do |t|
      t.integer :number
      t.string :letter
      t.integer :students_count
      t.belongs_to :school_id

      t.timestamps
    end
  end
end
