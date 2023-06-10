class CouponsController < ApplicationController
  def index
    @coupons = Coupon.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    # @merchant = Merchant.find(params[:merchant_id])
    # @coupon = Coupon.find(params[:id])
    # if @coupon.nil?
    #   flash[:error] = "Coupon not found"
    #   redirect_to merchant_coupons_path(@merchant)
    # end
  end
end