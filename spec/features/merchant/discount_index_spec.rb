require "rails_helper"

RSpec.describe "Merchant Bulk Discount Index Page Spec" do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = create(:discount, merchant: @merchant1, bulk_quantity: 10, percentage_discount: 5)
    @discount2 = create(:discount, merchant: @merchant1, bulk_quantity: 20, percentage_discount: 10)

    @merchant2 = create(:merchant)
    # @item1, @item2, @item3, @item4 = create_list(:item, 4, merchant: @merchant, inventory: 50)
  end

  describe "As a merchant employee" do
    describe "When I visit my merchant dashboard" do
      it "I see a link to my bulk discounts index page" do
      end
      it "I click that link and am taken to my bulk discounts index page" do
      end
    end

    describe "When I visit my bulk discounts index page" do
      describe "If I have discounts" do
        it "I see a list of all my discounts and their details" do
        end
      end

      describe "If I do not have discounts" do
        it "I see a message that says I have not added any discounts yet" do
        end
      end
    end
  end
end
