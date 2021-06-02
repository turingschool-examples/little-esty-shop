# app/controllers/customer_controller.rb

class CustomersController < ApplicationController

  def create
    Customer.create(customer_params)
    redirect_to '/customers'
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    redirect_to '/customers'
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.all
  end

  def new
  end

  def show
  @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer)
    customer.save

    redirect_to action: 'show', id: params[:id]
  end

  private

  def customer_params
    params.permit(:first_name, :last_name)
  end
end