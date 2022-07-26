namespace :import do
    desc "import invoice, invoice items, items, merchants, and transactions data from CSV to database"
    task all:[:merchants, :items, :customers, :invoices, :invoice_items, :transactions] do 
        ActiveRecord::Base.connection.tables.each do |t|
            ActiveRecord::Base.connection.reset_pk_sequence!(t)
        end
    end
end