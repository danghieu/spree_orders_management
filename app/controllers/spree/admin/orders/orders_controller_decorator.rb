Spree::Admin::OrdersController.class_eval do
  def ready
    @order = Spree::Order.includes(:adjustments).friendly.find(params[:id])
    @order.shipment_state = "ready"
    @order.save
    flash[:success] = Spree.t(:shipment_ready)
    redirect_to :back
  end

  def fulfillment_list
    tomorow =  Date.today + 1
    @products=[]
    @shipments = Spree::Shipment.where(date_delivery: tomorow)
    @shipments.each do |shipment|
      shipment.manifest.each do |ma|
        product = ma.variant.product
        quantity = ma.quantity
        unless product.nil?
          dish = {product: product, quantity: quantity}
          flash = true
          unless @products.empty?
            @products.each do|p|
              if p[:product].id == product.id 
                p[:quantity] +=dish[:quantity]
                flash =false
              end
            end
            @products<<dish if flash
          else
            @products<<dish
          end
        end
      end
    end
    @products.sort_by { |a| a[:product].name }
  end
end
