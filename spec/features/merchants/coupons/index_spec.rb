require "rails_helper"

RSpec.describe "Merchant Coupons Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Dog Care")
    @active_coupon1 = Coupon.create!( coupon_name: "53off", coupon_code: "Feee", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
    @active_coupon2 = Coupon.create!( coupon_name: "12off", coupon_code: "TensdfsdaER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
    @active_coupon3 = Coupon.create!( coupon_name: "16off", coupon_code: "ffddadsf", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
    @active_coupon4 = Coupon.create!( coupon_name: "3off", coupon_code: "rFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
    @deactive_coupon1 = Coupon.create!( coupon_name: "2%off", coupon_code: "TVE", merchant_id: @merchant2.id, discount_amount: 0.25, discount_type: 0) 
    @deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "RCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 
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

  end

  it "coupon name is a link to it's show page" do
    visit merchant_coupons_path(@merchant1)
    

    expect(page).to have_link("#{@active_coupon1.coupon_name}")
   


    click_link("#{@active_coupon1.coupon_name}")

    expect(current_path).to eq(merchant_coupon_path(@merchant1, @active_coupon1))
  end

  it "goes to another coupon show page" do
    visit merchant_coupons_path(@merchant1)

    click_link("#{@deactive_coupon2.coupon_name}")

    expect(current_path).to eq(merchant_coupon_path(@merchant1, @deactive_coupon2))
  end



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
    select "Deactivated", from: 'Status'
    
    
    click_button("Submit")
    expect(current_path).to eq(merchant_coupons_path(@merchant1))
    expect(page).to have_content(@active_coupon1.discount_amount)
    expect(page).to have_content("Shiny New Item")
  end
end

