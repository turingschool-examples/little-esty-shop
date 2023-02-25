require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should have_many :invoices }
  it { should have_many(:transactions).through(:invoices)} 

  let!(:moira) { Customer.create!(first_name: "Moira", last_name: "Rose") }
  let!(:alexis) { Customer.create!(first_name: "Alexis", last_name: "Rose") }
  let!(:david) { Customer.create!(first_name: "David", last_name: "Rose") }
  let!(:johnny) { Customer.create!(first_name: "Johnny", last_name: "Rose") }
  let!(:roland) { Customer.create!(first_name: "Roland", last_name: "Schitt") }
  let!(:josalyn) { Customer.create!(first_name: "Josalyn", last_name: "Schitt") }
  let!(:stevie) { Customer.create!(first_name: "Stevie", last_name: "Budd") }

  let!(:black_dress){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
  let!(:black_sunglasses){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
  let!(:black_feather_boa){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
  let!(:obsidian_ring){ moira.invoices.create!(customer_id: moira.id, status: "completed") }
  let!(:red_lipstick){ moira.invoices.create!(customer_id: moira.id, status: "completed") }

  let!(:gold_bangle){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }
  let!(:boho_dress){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }
  let!(:headband){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }
  let!(:hoop_earrings){ alexis.invoices.create!(customer_id: alexis.id, status: "completed") }

  let!(:titanium_ring){ david.invoices.create!(customer_id: david.id, status: "completed") }
  let!(:hand_cream){ david.invoices.create!(customer_id: david.id, status: "completed") }
  let!(:goat_cheese){ david.invoices.create!(customer_id: david.id, status: "completed") }

  let!(:cuff_links){ johnny.invoices.create!(customer_id: johnny.id, status: "completed") }
  let!(:tie){ johnny.invoices.create!(customer_id: johnny.id, status: "completed") }

  let!(:floral_shirt){ josalyn.invoices.create!(customer_id: josalyn.id, status: "completed") }

  let!(:flannel_shirt){ stevie.invoices.create!(customer_id: stevie.id, status: "completed") }

  let!(:fishnet_tights){ roland.invoices.create!(customer_id: roland.id, status: "cancelled") }

  before (:each) do
    Transaction.create!(invoice_id: black_dress.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: black_sunglasses.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: black_feather_boa.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: obsidian_ring.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: red_lipstick.id, credit_card_number: 4654405418249632, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: gold_bangle.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: boho_dress.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: headband.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: hoop_earrings.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: titanium_ring.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: hand_cream.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: goat_cheese.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: cuff_links.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")
    Transaction.create!(invoice_id: tie.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: floral_shirt.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: flannel_shirt.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "success")

    Transaction.create!(invoice_id: fishnet_tights.id, credit_card_number: 45802512365152012, credit_card_expiration_date: "09/01/2026", result: "failed")
  end

  it "returns the top 5 customers with successful transactions" do 
    
    expect(Customer.customers_transactions[0].full_name).to eq("#{moira.first_name} #{moira.last_name}")
    expect(Customer.customers_transactions[0].successful_order).to eq(5)

    expect(Customer.customers_transactions[1].full_name).to eq("#{alexis.first_name} #{alexis.last_name}")
    expect(Customer.customers_transactions[1].successful_order).to eq(4)

    expect(Customer.customers_transactions[2].full_name).to eq("#{david.first_name} #{david.last_name}")
    expect(Customer.customers_transactions[2].successful_order).to eq(3)

    expect(Customer.customers_transactions[3].full_name).to eq("#{johnny.first_name} #{johnny.last_name}")
    expect(Customer.customers_transactions[3].successful_order).to eq(2)

    expect(Customer.customers_transactions[4].full_name).to eq("#{josalyn.first_name} #{josalyn.last_name}")
    expect(Customer.customers_transactions[4].successful_order).to eq(1)
  end
end
