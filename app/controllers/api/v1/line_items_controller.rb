module API::V1
  class LineItemsController < ApiController
    before_action :set_order
    before_action :set_order_line_item, only: [:show, :update, :destroy]

    def index
      json_response(@order.line_items)
    end

    def create
      @order.line_items.create!(line_item_params)
      json_response(@order.line_items, :created)
    end

    def show
      json_response(@line_item)
    end

    def update
      @line_item.update(line_item_params)
      head :no_content
    end

    def destroy
      @line_item.destroy
      head :no_content
    end

    private

    def line_item_params
      params.permit(:price, :qty, :description)
    end

    def set_order
      @order = Order.find(params[:order_id])
    end

    def set_order_line_item
      @line_item = @order.line_items.find_by!(id: params[:id]) if @order
    end
  end
end
