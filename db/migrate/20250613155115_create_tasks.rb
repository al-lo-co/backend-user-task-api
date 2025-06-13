class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.integer :status, default: 0
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
