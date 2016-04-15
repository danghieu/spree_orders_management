Spree::Admin::PaymentsController.class_eval do
 def load_data
        @amount = params[:amount] || load_order.total
        @payment_methods = Spree::PaymentMethod.available(:back_end)
        if @payment and @payment.payment_method
          @payment_method = @payment.payment_method
        else
          @payment_method = @payment_methods.first
        end
      end

end