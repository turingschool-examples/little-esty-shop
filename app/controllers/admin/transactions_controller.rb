# app/controllers/transaction_controller.rb

class TransactionsController < ApplicationController

  def create
    Transaction.create(transaction_params)
    redirect_to '/transactions'
  end

  def destroy
    transaction = Transaction.find(params[:id])
    transaction.destroy
    redirect_to '/transactions'
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def index
    @transactions = Transaction.all
  end

  def new
  end

  def show
  @transaction = Transaction.find(params[:id])
  end

  def update
    transaction = Transaction.find(params[:id])
    transaction.update(transaction)
    transaction.save

    redirect_to action: 'show', id: params[:id]
  end

  private

  def transaction_params
    params.permit(:credit_card_number,
                  :credit_card_expiration_date,
                  :result,
                  :invoice_id)
  end
end