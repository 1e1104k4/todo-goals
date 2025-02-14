class AddUserRefToGoals < ActiveRecord::Migration[8.0]
  def change
    add_reference :goals, :user, null: false, foreign_key: true, default: 0
  end
end
