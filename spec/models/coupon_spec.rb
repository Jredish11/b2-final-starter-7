require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end
  
  describe "validations" do
    it { should validate_presence_of(:coupon_name) }
    it { should validate_presence_of(:coupon_code) }
    it { should validate_presence_of(:discount_amount) }
    it { should validate_presence_of(:discount_type) }
  end
end