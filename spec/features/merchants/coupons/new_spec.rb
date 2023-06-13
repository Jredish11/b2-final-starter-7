require "rails_helper"

RSpec.describe "Merchant Coupons Create New Coupon Page" do
  describe "As a merchant when I visit create new Coupon Page" do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @active_coupon1 = Coupon.create!( coupon_name: "53333", coupon_code: "FRdfdddfasd", merchant_id: @merchant1.id, status: 1, discount_amount: 53, discount_type: 1) 
      @active_coupon2 = Coupon.create!( coupon_name: "13offdf", coupon_code: "Tedsfsdf", merchant_id: @merchant1.id, status: 1, discount_amount: 95, discount_type: 1) 
      @active_coupon3 = Coupon.create!( coupon_name: "1dfd8off", coupon_code: "dfsaff", merchant_id: @merchant1.id, status: 1, discount_amount: 38, discount_type: 1) 
      @active_coupon4 = Coupon.create!( coupon_name: "49dfdfoff", coupon_code: "FdsdoVER", merchant_id: @merchant1.id, status: 1, discount_amount: 46, discount_type: 1) 
      @active_coupon5 = Coupon.create!( coupon_name: "abde", coupon_code: "FdfdaeeeeR", merchant_id: @merchant1.id, discount_amount: 9, discount_type: 1) 
      @deactive_coupon1 = Coupon.create!( coupon_name: "29dsfsfd%off", coupon_code: "TWsdfsdfIVE", merchant_id: @merchant1.id, discount_amount: 0.23, discount_type: 0) 
      @deactive_coupon2 = Coupon.create!( coupon_name: "ninesdfsdfoff", coupon_code: "10dfssadfENT", merchant_id: @merchant1.id, discount_amount: 0.19, discount_type: 0) 

      visit new_merchant_coupon_path(@merchant1)
      
    end
    
      
    
      # I am taken to a new page where I see a form to add a new coupon.
      # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
      # And click the Submit button
      # I'm taken back to the coupon index page 
      # And I can see my new coupon listed.
      
      
      # * Sad Paths to consider: 
      # 1. This Merchant already has 5 active coupons
      # 2. Coupon code entered is NOT unique
  
    it "displays a form to add a new coupon" do
      expect(page).to have_content("Create New Coupon")
      expect(page).to have_field("Coupon name")
      expect(page).to have_field("Coupon code")
      expect(page).to have_field("Discount amount")
      expect(page).to have_field("Discount type")
      expect(page).to have_button("Submit")
    end
    
    it "user can fill form out and clicks submit, redirected back to coupon index page" do
      fill_in 'Coupon name', with: 'Sweet'
      fill_in 'Coupon code', with: 'shiny'
      fill_in 'Discount amount', with: 1
      select "Dollar off", from: 'Discount type'
      select "Deactivated", from: 'Status'
      
      
      click_button("Submit")
      
      expect(current_path).to eq(merchant_coupons_path(@merchant1))
    end
    
    it "does not create a new coupon if there are already 5 active coupons for the same merchant" do
      @active_coupon5.update(status: 1)
      @deactive_coupon1.update(status: 1)

      fill_in 'Coupon name', with: "twotwo"
      fill_in 'Coupon code', with: "TWsdfsdfIVE"
      fill_in 'Discount amount', with: 22
      select "Dollar off", from: 'Discount type'
      select "Activated", from: 'Status'

      
      
      click_button("Submit")
      save_and_open_page
      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
      expect(page).to have_content("Already 5 active coupons for this merchant")
      expect(page).to_not have_content("twotwo")
    end
    
    it "does not create a new coupon if the code already exists" do
      fill_in 'Coupon name', with: "twotwo"
      fill_in 'Coupon code', with: "TWsdfsdfIVE"
      fill_in 'Discount amount', with: 22
      select "Dollar off", from: 'Discount type'
      select "Deactivated", from: 'Status'
      
      
      click_button("Submit")
      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
      expect(page).to have_content("Form has empty fields or the coupon code already exists. Please check your inputs.")
      expect(page).to_not have_content("twotwo")

      
    end
  end
end

    