Spree::Admin::OrdersController.class_eval do
  before_action :load_data, only: [:fulfillment_list]
  def ready
    @order = Spree::Order.friendly.find(params[:id])
    @order.shipment_state = "ready"
    @order.save
    flash[:success] = Spree.t(:shipment_ready)
    redirect_to :back
  end

  def load_order
    @order = Spree::Order.includes(order_includes).friendly.find(params[:id])
    authorize! action, @order
  end

  def load_data
    @time = Dish::TimeFrame.all
    @date =  Date.today
    @s_m = @time.first
    @dish_types = Dish::DishType.all
  end

  def fulfillment_list
    if params[:fulfillment].present? && fulfill_params[:date].present? &&fulfill_params[:time].present?
      @date =  fulfill_params[:date]
      @s_m  =  Dish::TimeFrame.find(fulfill_params[:time])
      if request.get?
        @ready 	 =  get_fulfillment_data(@date,@s_m,'ready')
        @shipped =  get_fulfillment_data(@date,@s_m, 'shipped')
      else #request.post?
        @shipments = get_shipments(@date,@s_m,'ready')
        @shipments.each do |shipment|
          unless shipment.shipped?
            shipment.ship!
          end
        end
        @ready 	 =  get_fulfillment_data(@date,@s_m,'ready')
       	@shipped =  get_fulfillment_data(@date,@s_m, 'shipped')
      end
    else
      @ready = get_fulfillment_data(Date.today,@time.first,'ready')
      @shipped = get_fulfillment_data(Date.today,@time.first,'shipped')
    end
    

  end

  def get_fulfillment_data(date,time,state)
    @products=[]
    @shipments = get_shipments(date,time,state)
    @shipments.each do |shipment|
      shipment.manifest.each do |ma|
        product= ma.variant.product
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

  def get_shipments(date,time,state)
    @shipments = Spree::Shipment.where("time_frame_id=? and date_delivery=? and state= ?",time.id,date,state).includes(shipment_includes)
  end

  private
  def fulfill_params
    params.require(:fulfillment).permit(:date,:time)
  end

  def order_includes
    [:shipments =>shipment_includes,:payments =>[:payment_method]]
  end

  def shipment_includes
    [:time_frame,:stock_location,:shipping_rates,inventory_units: [:line_item,:variant =>[:product=>[:dish_type,:master => [:images],:ingredients => :images]]]]
  end
end
