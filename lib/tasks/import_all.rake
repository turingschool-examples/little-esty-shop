namespace :import do
    desc "import invoice, invoice items, items, merchants, and transactions data from CSV to database"
    task all:[:customers, :invoice_items, :invoices, :items, :merchants, :transactions] do 
        ActiveRecord::Base.connection.tables.each do |t|
            ActiveRecord::Base.connection.reset_pk_sequence!(t)
        end
    end
end