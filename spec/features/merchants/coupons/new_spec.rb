require "rails_helper"

RSpec.describe "Merchant Coupons Create New Coupon Page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @active_coupon1 = Coupon.create!( coupon_name: "5off", coupon_code: "FIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
    @active_coupon2 = Coupon.create!( coupon_name: "10off", coupon_code: "TenER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
    @active_coupon3 = Coupon.create!( coupon_name: "15off", coupon_code: "fif", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
    @active_coupon4 = Coupon.create!( coupon_name: "45off", coupon_code: "FourFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
    @deactive_coupon1 = Coupon.create!( coupon_name: "25%off", coupon_code: "TWOFIVE", merchant_id: @merchant1.id, discount_amount: 0.25, discount_type: 0) 
    @deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "10PERCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 
    
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
    fill_in 'Coupon name', with: 'Shiny New Item'
    fill_in 'Coupon code', with: 'Super Duper Shiny'
    fill_in 'Discount amount', with: 25
    select "Dollar off", from: 'Discount type'
    
    
    click_button("Submit")
    
    expect(current_path).to eq(merchant_coupons_path(@merchant1))
  end
end

    