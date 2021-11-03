rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

in rails_helper counts as non-covered code
