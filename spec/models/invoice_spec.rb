require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
    it { should belong_to(:coupon).optional}
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @merchant1 = Merchant.create!(name: 'Hair Care')
      expect(@invoice_1.total_revenue).to eq(100)
    end

    it "grand_total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @active_coupon1 = Coupon.create!( coupon_name: "53off", coupon_code: "Feee", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
      @active_coupon2 = Coupon.create!( coupon_name: "12off", coupon_code: "TensdfsdaER", merchant_id: @merchant1.id, status: 1, discount_amount: 0.10, discount_type: 0) 
      @active_coupon3 = Coupon.create!( coupon_name: "13off", coupon_code: "Tensdfs333daER", merchant_id: @merchant1.id, status: 1, discount_amount: 100, discount_type: 1) 
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: @active_coupon1.id)
      @invoice_3 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: @active_coupon3.id)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: @active_coupon2.id)
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @ii_14 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_15 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @ii_12 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
      @ii_13 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 1)

      expect(@invoice_3.total_off).to eq(100)
      expect(@invoice_1.grand_total_revenue).to eq(95)
      expect(@invoice_2.grand_total_revenue).to eq(90)
      expect(@invoice_3.grand_total_revenue).to eq(0)

    end
  end
end
