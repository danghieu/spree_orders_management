class CreateTimeFrames < ActiveRecord::Migration
  def change
    create_table :time_frames do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end
  end
end
