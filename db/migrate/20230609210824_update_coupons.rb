class UpdateCoupons < ActiveRecord::Migration[7.0]
  def change
    remove_column :coupons, :percent_off
    remove_column :coupons, :dollar_off
    add_index :coupons, :coupon_code, unique: true
    add_column :coupons, :discount_amount, :decimal
    add_column :coupons, :discount_type, :integer
  end
end
