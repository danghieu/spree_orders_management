class AddDateToShipping < ActiveRecord::Migration
  def change
    add_column :spree_shipping_rates,  :date_delivery, :date, :default => Date.today
  end
end
