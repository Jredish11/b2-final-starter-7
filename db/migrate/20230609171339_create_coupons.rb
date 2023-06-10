class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :coupon_name
      t.string :coupon_code
      t.float :percent_off
      t.integer :dollar_off
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
