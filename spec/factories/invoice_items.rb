FactoryBot.define do
  factory name:customer do
    quantity {1}
    unit_price {''}
    item {nil}
end

create_enum :application_status %w(in progress pending accepted rejected)
t.enum :status, enum_name: :application_status, default: 'in_progress', null: false

app = Application.create! attributes_for(:application) <--- this goes in it statement

gem 'activerecord-postgres-enum'

enum status: { in_progress: 'in_progress', pending: 'pending', accepted: 'accepted', rejected: 'rejected' }