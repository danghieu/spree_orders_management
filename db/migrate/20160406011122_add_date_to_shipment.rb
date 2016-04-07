class AddDateToShipment < ActiveRecord::Migration
  def change
  	add_column :spree_shipments,  :date_delivery, :date, :default => DateTime.now.to_date
  end
end
