require "rails_helper"

RSpec.describe "Merchant Coupons Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Dog Care")
    @active_coupon1 = Coupon.create!( coupon_name: "5off", coupon_code: "FIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
    @active_coupon2 = Coupon.create!( coupon_name: "10off", coupon_code: "TenER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
    @active_coupon3 = Coupon.create!( coupon_name: "15off", coupon_code: "fif", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
    @active_coupon4 = Coupon.create!( coupon_name: "45off", coupon_code: "FourFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
    @deactive_coupon1 = Coupon.create!( coupon_name: "25%off", coupon_code: "TWOFIVE", merchant_id: @merchant2.id, discount_amount: 0.25, discount_type: 0) 
    @deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "10PERCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 
  end


  it "displays all of the coupons names including their amount off" do
    visit merchant_coupons_path(@merchant1)
    expect(page).to have_content("Merchant Coupons Index")
    expect(page).to have_content(@active_coupon1.coupon_name)
    expect(page).to have_content(@active_coupon1.discount_amount)
    expect(page).to have_content(@active_coupon2.coupon_name)
    expect(page).to have_content(@active_coupon2.discount_amount)
    expect(page).to have_content(@active_coupon3.coupon_name)
    expect(page).to have_content(@active_coupon3.discount_amount)
    expect(page).to have_content(@active_coupon4.coupon_name)
    expect(page).to have_content(@active_coupon4.discount_amount)
    expect(page).to have_content(@deactive_coupon2.coupon_name)
    expect(page).to have_content(@deactive_coupon2.discount_amount)
    # expect(page).to_not have_content(@deactive_coupon1.coupon_name)
    # expect(page).to_not have_content(@deactive_coupon1.discount_amount)
  end

  it "coupon name is a link to it's show page" do
    visit merchant_coupons_path(@merchant1)
    

    expect(page).to have_link("#{@active_coupon1.coupon_name}")
    # expect(page).to_not have_link("#{@deactive_coupon1.coupon_name}")


    click_link("#{@active_coupon1.coupon_name}")

    expect(current_path).to eq(merchant_coupon_path(@merchant1, @active_coupon1))
  end

  it "goes to another coupon show page" do
    visit merchant_coupons_path(@merchant1)

    click_link("#{@deactive_coupon2.coupon_name}")

    expect(current_path).to eq(merchant_coupon_path(@merchant1, @deactive_coupon2))
  end

  #US 2
 
  # I am taken to a new page where I see a form to add a new coupon.
  # When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
  # And click the Submit button
  # I'm taken back to the coupon index page 
  # And I can see my new coupon listed.
  
  
  # * Sad Paths to consider: 
  # 1. This Merchant already has 5 active coupons
  # 2. Coupon code entered is NOT unique

  it "displays a link to create new coupon" do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_link("Create New Coupon")
  end

  it "user clicks on link, taken to new coupon page" do
    visit merchant_coupons_path(@merchant2)

    click_link("Create New Coupon")

    expect(current_path).to eq(new_merchant_coupon_path(@merchant2))
  end

  it "shows newly created coupon on the index page" do
    visit new_merchant_coupon_path(@merchant1)
    fill_in 'Coupon name', with: 'Shiny New Item'
    fill_in 'Coupon code', with: 'Super Duper Shiny'
    fill_in 'Discount amount', with: 25
    select "Dollar off", from: 'Discount type'
    
    
    click_button("Submit")
    save_and_open_page
    expect(current_path).to eq(merchant_coupons_path(@merchant1))
    expect(page).to have_content(@active_coupon1.discount_amount)
    expect(page).to have_content("Shiny New Item")
  end
end