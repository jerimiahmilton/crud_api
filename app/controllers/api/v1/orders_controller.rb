module API::V1
  class OrdersController < ApiController
    before_action :set_customer
    before_action :set_customer_order, only: [:show, :update, :destroy]

    def index
      json_response(@customer.orders)
    end

    def create
      @customer.orders.create!(order_params)
      json_response(@customer.orders, :created)
    end

    def show
      json_response(@order)
    end

    def update
      @order.update(order_params)
      head :no_content
    end

    def destroy
      @order.destroy
      head :no_content
    end

    private

    def order_params
      params.permit(:description)
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_customer_order
      @order = @customer.orders.find_by!(id: params[:id]) if @customer
    end
  end
end
