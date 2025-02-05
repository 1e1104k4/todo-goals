class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
