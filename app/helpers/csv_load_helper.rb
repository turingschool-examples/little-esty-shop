module CSVLoadHelper
  def csv_import(model_name, row)
    if model_name == Invoice
      row[:status] = row[:status].sub(' ','_')
    elsif model_name == Transaction
      if row[:result] == 'success'
        row[:result] = true
      elsif row[:result] == 'failed'
        row[:result] = false
      end
    end

    model_name.find_or_create_by!(row.to_hash)
  end
end
