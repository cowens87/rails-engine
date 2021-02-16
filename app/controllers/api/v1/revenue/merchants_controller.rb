class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    revenue = Merchant.total_revenue_between_dates(params[:start], params[:end])
    render json: RevenueSerializer.revenue(revenue)
  end
  
  def show
    revenue = Merchant.find(params[:id]).total_revenue
    render json: RevenueSerializer.revenue(revenue)
  end
end