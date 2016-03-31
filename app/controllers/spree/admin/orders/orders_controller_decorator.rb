Spree::Admin::OrdersController.class_eval do
  def ready
  	@order = Spree::Order.includes(:adjustments).friendly.find(params[:id])
    @order.shipment_state = "ready"
    @order.save
    flash[:success] = Spree.t(:shipment_ready)
    redirect_to :back
  end
end
