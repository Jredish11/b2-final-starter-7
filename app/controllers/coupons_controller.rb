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
    if coupon.save
      redirect_to merchant_coupons_path(merchant)
    else
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "Form filled incorrectly. Please check your inputs."
    end
  end
end

private

def coupon_params
  params.permit(:coupon_name, :coupon_code, :discount_amount, :discount_type, :status)
end