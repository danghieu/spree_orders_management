Spree::Api::ShipmentsController.class_eval do
  def update
    @shipment = Spree::Shipment.accessible_by(current_ability, :update).readonly(false).friendly.find(params[:id])
    @shipment.update_attributes_and_order(shipment_params)
    @shipment.date_delivery = params[:shipment][:date_delivery]
    @shipment.save
    respond_with(@shipment.reload, default_template: :show)
  end
end
