class AddTimeFrameToShipment < ActiveRecord::Migration
  def change
    add_column :spree_shipments,  :time_frame_id, :integer, :default => Dish::TimeFrame.first.id
    add_foreign_key :spree_shipments, :time_frames, column: 'time_frame_id'
  end
end
