class DisbursementsController < ApplicationController
  before_action :require_week

  def index
    merchant = params[:merchant]
    week = params[:week]

    result = {}
    if (merchant)
      disbursement = Disbursement
        .joins(:merchant)
        .where(week: week, merchant_id: merchant)
        .first
      result = format_disbursement(disbursement)
    else
      disbursements = Disbursement
        .joins(:merchant)
        .where(week: week)
      result = format_disbursements(disbursements)
    end

    render json: result
  end

  private

  def require_week
    unless params[:week]
      render json: { error: "Week parameter required" }
      return
    end
  end

  def format_disbursement(disbursement)
    { disbursement.merchant.name => disbursement.amount.format }
  end

  def format_disbursements(disbursements)
    disbursements.map { |disbursement| format_disbursement(disbursement) }
  end
end
