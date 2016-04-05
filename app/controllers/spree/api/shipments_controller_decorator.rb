Spree::Api::ShipmentsController.class_eval do
  def update
    ship_rate = Spree::ShippingRate.find(shipment_params[:selected_shipping_rate_id])
    ship_rate.date_delivery = params[:shipment][:date_delivery]
    ship_rate.save
    @shipment = Spree::Shipment.accessible_by(current_ability, :update).readonly(false).friendly.find(params[:id])
    @shipment.update_attributes_and_order(shipment_params)
    
    respond_with(@shipment.reload, default_template: :show)
  end
end
