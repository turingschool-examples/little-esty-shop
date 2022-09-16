require 'rails_helper'
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
  let!(:eddie) { Customer.create!(first_name: "Eddie", last_name: "Young")}
  let!(:leah) { Customer.create!(first_name: "Leah", last_name: "Anderson")}
  let!(:polina) { Customer.create!(first_name: "Polina", last_name: "Eisenberg")}

  let!(:alaina_invoice2) { alaina.invoices.create!(status: "in_progress")}
  let!(:eddie_invoice1) { eddie.invoices.create!(status: "completed", created_at: "2000-01-30 14:54:09")}
  let!(:eddie_invoice2) { eddie.invoices.create!(status: "completed")}
  let!(:polina_invoice1) { polina.invoices.create!(status: "completed")}
  let!(:polina_invoice2) { polina.invoices.create!(status: "cancelled")}
  let!(:leah_invoice1) { leah.invoices.create!(status: "cancelled")}
  let!(:leah_invoice2) { leah.invoices.create!(status: "in_progress")}


  describe 'instance methods' do
    describe '#incomplete_invoices' do
     it 'can return the invoices that have a status of in progress' do 

      expect(Invoice.incomplete_invoices).to eq([alaina_invoice2, leah_invoice2])
     end
    end
  end

end