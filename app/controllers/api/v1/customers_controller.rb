module API::V1
   class CustomersController < ApiController
     before_action :set_customer, only: [:show, :update, :destroy]

     def index
       @customers = Customer.all
       json_response(@customers)
     end

     def create
       @customer = Customer.create!(customer_params)
       json_response(@customer, :created)
     end

     def show
       json_response(@customer)
     end

     def update
       @customer.update(customer_params)
       head :no_content
     end

     def destroy
       @customer.destroy
       head :no_content
     end

     private

     def customer_params
       params.permit(:name)
     end

     def set_customer
       @customer = Customer.find(params[:id])
     end
  end
end
