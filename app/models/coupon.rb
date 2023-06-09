class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: [:activated, :deactivated]
  enum discount_type: [:percent_off, :dollar_off]
end