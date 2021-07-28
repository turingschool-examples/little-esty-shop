class AddStatusToInvoices < ActiveRecord::Migration[5.2]
  def up
      execute <<-SQL
        CREATE TYPE invoice_statuses AS ENUM ('cancelled', 'in progress', 'completed');
        ALTER TABLE invoices ALTER COLUMN status TYPE invoice_statuses USING status::invoice_statuses;
      SQL
    end

    def down
      execute <<-SQL
        DROP TYPE invoice_statuses;
      SQL
      change_column :invoices, :status, :integer
    end
end
