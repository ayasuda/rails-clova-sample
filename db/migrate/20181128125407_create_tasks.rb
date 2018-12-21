class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :list, foreign_key: true
      t.string :title
      t.datetime :completed_at

      t.timestamps
    end
  end
end
