class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :coupon_name, presence: true
  validates :coupon_code, presence: true, uniqueness: true
  validates :discount_amount, presence: true, numericality: { greater_than: 0 }
  validates :discount_type, presence: true, inclusion: { in: ['percent_off', 'dollar_off'] }

  enum status: [:deactivated, :activated]
  enum discount_type: [:percent_off, :dollar_off]

end