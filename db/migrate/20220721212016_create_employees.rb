class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :level
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
