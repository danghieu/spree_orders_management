Spree::Api::ShipmentsController.class_eval do
  def update
    @shipment = Spree::Shipment.accessible_by(current_ability, :update).readonly(false).friendly.find(params[:id])
    @shipment.date_delivery = params[:shipment][:date_delivery]
    @shipment.time_frame_id = params[:shipment][:selected_shipping_rate_id]
    @shipment.save
    respond_with(@shipment.reload, default_template: :show)
  end
end
