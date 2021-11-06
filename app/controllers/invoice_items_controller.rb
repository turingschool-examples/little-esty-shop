class InvoiceItemsController < ApplicationController
def update
  invoice_item = InvoiceItem.find(params[:id])
  invoice_item.update(invoice_item_params)
  
end

private

    def invoice_item_params
      params.require(:invoice_item).permit(:status)
    end
end
