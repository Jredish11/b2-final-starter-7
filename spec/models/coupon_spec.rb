require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:coupon_name) }
    it { should validate_presence_of(:coupon_code) }
    it { should validate_presence_of(:discount_amount) }
    it { should validate_presence_of(:discount_type) }
  end

  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @merchant2 = Merchant.create!(name: "Dog Care")
      
      @active_coupon1 = Coupon.create!( coupon_name: "53off", coupon_code: "Feee", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
      @active_coupon2 = Coupon.create!( coupon_name: "12off", coupon_code: "TensdfsdaER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
      @active_coupon3 = Coupon.create!( coupon_name: "16off", coupon_code: "ffddadsf", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
      @active_coupon4 = Coupon.create!( coupon_name: "3off", coupon_code: "rFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
      @deactive_coupon1 = Coupon.create!( coupon_name: "2%off", coupon_code: "TVE", merchant_id: @merchant2.id, discount_amount: 0.25, discount_type: 0) 
      @deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "RCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 
      
      @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
      @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
      @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
      @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
      @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
      @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")
  
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09", coupon_id: @active_coupon1.id)
      @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
      @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
      @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
      @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
      @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
      @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)
  
      @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
      @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
      @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
      @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
      @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
      @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
      @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)  
    
    end
    
    describe "#transaction_success_count" do
      it "counts the amount of successful transactions using a coupon" do
        expect(@active_coupon1.transaction_success_count).to eq(1)
      end
    end
  end
end