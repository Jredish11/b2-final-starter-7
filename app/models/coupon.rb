class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates :coupon_name, presence: true
  validates :coupon_code, presence: true
  validates :discount_amount, numericality: { greater_than: 0 }
  validates :discount_type, inclusion: { in: ['percent_off', 'dollar_off'] }

  enum status: [:deactivated, :activated]
  enum discount_type: [:percent_off, :dollar_off]

end