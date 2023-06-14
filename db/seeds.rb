# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# InvoiceItem.destroy_all
# Transaction.destroy_all
# Item.destroy_all
# Invoice.destroy_all
Coupon.destroy_all
# Customer.destroy_all
# Merchant.destroy_all
Rake::Task["csv_load:all"].invoke
@merchant1 = Merchant.create!(name: "Hair Care")
@merchant2 = Merchant.create!(name: "Dog Care")
@active_coupon1 = Coupon.create!( coupon_name: "5off", coupon_code: "FIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 5, discount_type: 1) 
@active_coupon2 = Coupon.create!( coupon_name: "10off", coupon_code: "TenER", merchant_id: @merchant1.id, status: 1, discount_amount: 10, discount_type: 1) 
@active_coupon3 = Coupon.create!( coupon_name: "15off", coupon_code: "fif", merchant_id: @merchant1.id, status: 1, discount_amount: 15, discount_type: 1) 
@active_coupon4 = Coupon.create!( coupon_name: "45off", coupon_code: "FourFIVER", merchant_id: @merchant1.id, status: 1, discount_amount: 45, discount_type: 1) 
@deactive_coupon1 = Coupon.create!( coupon_name: "25%off", coupon_code: "TWOFIVE", merchant_id: @merchant2.id, discount_amount: 0.25, discount_type: 0) 
@deactive_coupon2 = Coupon.create!( coupon_name: "tenoff", coupon_code: "10PERCENT", merchant_id: @merchant1.id, discount_amount: 0.10, discount_type: 0) 

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

