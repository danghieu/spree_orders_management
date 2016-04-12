Spree::Shipment.class_eval do
	belongs_to :time_frame, :class_name => "Dish::TimeFrame",foreign_key: "time_frame_id"
end