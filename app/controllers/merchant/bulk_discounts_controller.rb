class Merchant::BulkDiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.bulk_discounts
  end
  def new
  end
  def create
    merchant = current_user.merchant
    discount = merchant.bulk_discounts.new(bulk_discount_params)
    if discount.valid?
      discount.save
      redirect_to merchant_discounts_path
    else
      generate_flash(discount)
      redirect_to new_merchant_discount_path
    end
  end

  private

  def bulk_discount_params
    params.permit(:bulk_quantity, :percentage_discount)
  end
end