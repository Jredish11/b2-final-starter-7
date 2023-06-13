require "rails_helper"

RSpec.describe "Merchant Coupons Show Page" do
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


      # As a merchant 
      # When I visit a merchant's coupon show page 
      # I see that coupon's name and code 
      # And I see the percent/dollar off value
      # As well as its status (active or inactive)
      # And I see a count of how many times that coupon has been used.

      # (Note: "use" of a coupon should be limited to successful transactions.)
  describe "When a merchant visits a merchant's coupon show page" do
    it "displays that coupon's name and code" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      
      expect(page).to have_content("Coupon's Page")
      expect(page).to have_content(@active_coupon1.coupon_name)
      expect(page).to have_content(@active_coupon1.coupon_code)
    end

    it "display of the percent/dollar off value" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      expect(page).to have_content(@active_coupon1.discount_amount)
      expect(page).to_not have_content(@active_coupon2.discount_amount)
    end

    it "displays it's status as active or inactive" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      expect(page).to have_content(@active_coupon1.status)
      expect(page).to have_content("activated")
    end

    it "does the same for another page" do
      visit merchant_coupon_path(@merchant1, @deactive_coupon1)
      expect(page).to have_content(@deactive_coupon1.status)
      expect(page).to have_content("deactivated")
    end

    it "displays the count of how many times the coupon has been used in a transaction" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      expect(page).to have_content(@active_coupon1.transaction_success_count)
      expect(page).to have_content("count: 1")
    end

                #us 4 4. Merchant Coupon Deactivate

            # As a merchant 
            # When I visit one of my active coupon's show pages
            # I see a button to deactivate that coupon
            # When I click that button
            # I'm taken back to the coupon show page 
            # And I can see that its status is now listed as 'inactive'.

            # * Sad Paths to consider: 
            # 1. A coupon cannot be deactivated if there are any pending invoices with that coupon.

    it "displays a button to deactivate that coupon" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      within "#activated" do
        expect(page).to have_button("deactivate")
      end
      
      visit merchant_coupon_path(@merchant1, @deactive_coupon2)
      within "#activated" do
        expect(page).to_not have_button("deactivate")
      end
    end

    it "when button is clicked taken back to the coupon show page and see status as inactive" do
      visit merchant_coupon_path(@merchant1, @active_coupon1)
      within "#activated" do
        expect(@active_coupon1.status).to eq("activated")
        click_button("deactivate")
        @active_coupon1.reload
        save_and_open_page
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @active_coupon1))
        expect(@active_coupon1.status).to eq("deactivated")
      end
    end
  end
end