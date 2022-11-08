class AdminController < ApplicationController
  def index
<<<<<<< HEAD

=======
    @top_customers = Customer.top_5_by_successful_transactions
    @incomplete_invoice_items = InvoiceItem.not_shipped.sort_by_invoice_creation_date
>>>>>>> c63705e08469b4ad57fec8a02c9a4a44be7e6c46
  end
end
