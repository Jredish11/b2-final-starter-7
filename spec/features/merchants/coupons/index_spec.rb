require "rails_helper"

RSpec.describe "Merchant Coupons Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @active_coupon1 = Coupon.create!( coupon_name: "5off", coupon_code: "FIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
    @active_coupon2 = Coupon.create!( coupon_name: "10off", coupon_code: "TenER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
    @active_coupon3 = Coupon.create!( coupon_name: "15off", coupon_code: "fif", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
    @active_coupon4 = Coupon.create!( coupon_name: "45off", coupon_code: "FourFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
    @deactive_coupon1 = Coupon.create!( coupon_name: "25%off", coupon_code: "TWOFIVE", merchant_id: @merchant1.id, discount_amount: 0.25, discount_type: 0) 
    @deactive_coupon2 = Coupon.create!( coupon_name: "10%off", coupon_code: "10PERCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 
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
    expect(page).to have_content(@deactive_coupon1.coupon_name)
    expect(page).to have_content(@deactive_coupon1.discount_amount)
    expect(page).to have_content(@deactive_coupon2.coupon_name)
    expect(page).to have_content(@deactive_coupon2.discount_amount)
  end

  it "coupon name is a link to it's show page" do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_link(@active_coupon1.coupon_name)

    click_link(@active_coupon1.coupon_name)
  end
end