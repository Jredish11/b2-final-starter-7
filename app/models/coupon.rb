class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: [:activated, :deactivated]
end