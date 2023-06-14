class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  belongs_to :coupon, optional: true
  

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total_revenue
    total_revenue - total_off
  end

  # private 

  def total_off
    if coupon.nil?
      return 0
    elsif coupon.discount_type == "percent_off"
      (coupon.discount_amount.to_f * 100).round
    else coupon.discount_type == "dollar_off"
      coupon.discount_amount.to_f
    end
  end


end
