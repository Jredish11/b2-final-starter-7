class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: [:deactivated, :activated]
  enum discount_type: [:percent_off, :dollar_off]
end