require 'rails_helper' 

RSpec.describe Item do 
  describe 'relationships' do 
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe '#group_by_status' do 
    before :each do 
      @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
      @whb = Merchant.create!(name: "WHB")
      @something= @klein_rempel.items.create!(name: "Something", description: "A thing that is something", unit_price: 300, status: "Enabled")
      @another = @klein_rempel.items.create!(name: "Another", description: "One more something", unit_price: 150, status: "Enabled")
      @other = @whb.items.create!(name: "Other", description: "One more something", unit_price: 150)
    end

    it 'can be grouped by status enabled or disabled' do 
      require 'pry'; binding.pry
      expect(Item.group_by_enabled).to eq([@something, @another])
      expect(Item.group_by_enabled).to_not eq([@other])
    end
  end

end