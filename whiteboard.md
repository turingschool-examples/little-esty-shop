rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

in rails_helper counts as non-covered code
- remember to add this back to the index.html.erb file for Dashboard
<%# <h3>Top 5 Customers:</h3> %>
<%# <% @merchant.top_customers.each do |customer| %> %>
  <%# <p><%= customer.name</p> %> %>
<%# <% end %> %>