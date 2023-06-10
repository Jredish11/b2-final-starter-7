# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke
@merchant1 = Merchant.create!(name: "Hair Care")
@merchant2 = Merchant.create!(name: "Dog Care")
active_coupon1 = Coupon.create!( coupon_name: "5off", coupon_code: "FIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
active_coupon2 = Coupon.create!( coupon_name: "10off", coupon_code: "TenER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
active_coupon3 = Coupon.create!( coupon_name: "15off", coupon_code: "fif", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
active_coupon4 = Coupon.create!( coupon_name: "45off", coupon_code: "FourFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
deactive_coupon1 = Coupon.create!( coupon_name: "25%off", coupon_code: "TWOFIVE", merchant_id: @merchant2.id, discount_amount: 0.25, discount_type: 0) 
deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "10PERCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 