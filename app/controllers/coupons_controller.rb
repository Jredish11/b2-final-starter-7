class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def show
 
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    coupon = merchant.coupons.new(coupon_params)
    if merchant.max_active_coupons?
      flash[:alert] = "Already 5 active coupons for this merchant"
      redirect_to new_merchant_coupon_path(merchant)
    elsif coupon.save
      redirect_to merchant_coupons_path(merchant)
    else
      flash[:alert] = "Form has empty fields or the coupon code already exists. Please check your inputs."
      redirect_to new_merchant_coupon_path(merchant)
    end
  end
end

private

def coupon_params
  params.permit(:coupon_name, :coupon_code, :discount_amount, :discount_type, :status)
end