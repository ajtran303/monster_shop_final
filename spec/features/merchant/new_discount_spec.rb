require "rails_helper"

RSpec.describe "New Merchant Bulk Discount Spec" do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = create(:discount, merchant: @merchant1)
    @employee1 = create(:employee, merchant: @merchant1, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee1)
  end

  describe "As a merchant employee" do
    describe "On my bulk discount index page" do
      it "There is a link to create a new bulk discount" do
        visit merchant_discounts_path
        expect(page).to have_link("Create New Bulk Discount", href: "/merchant/discounts/new")
      end
    end

    it "Filling the form out completely will create a new bulk discount" do
      visit new_merchant_discount_path
      expect(BulkDiscount.count).to eq(1)

      fill_in :bulk_quantity, with: 40
      fill_in :percentage_discount, with: 10
      click_button "Create Bulk Discount"

      expect(BulkDiscount.count).to eq(2)
      expect(current_path).to eq(merchant_discounts_path)
    end

    describe "Form validation: I cannot make a new discount after" do
      before :each do
        visit new_merchant_discount_path
      end

      it "Failing to fill out the form completely" do
        expect(BulkDiscount.count).to eq(1)

        # fill_in :bulk_quantity, with: 40
        fill_in :percentage_discount, with: 10
        click_button "Create Bulk Discount"

        expect(BulkDiscount.count).to eq(1)
        expect(current_path).to eq(new_merchant_discount_path)
        expect(page).to have_content("bulk_quantity: [\"is not a number\"]")


        fill_in :bulk_quantity, with: 40
        # fill_in :percentage_discount, with: 10
        click_button "Create Bulk Discount"

        expect(BulkDiscount.count).to eq(1)
        expect(current_path).to eq(new_merchant_discount_path)
        expect(page).to have_content("percentage_discount: [\"Discount must be percentage from 1 - 100\"]")


        # fill_in :bulk_quantity, with: 40
        # fill_in :percentage_discount, with: 10
        click_button "Create Bulk Discount"

        expect(BulkDiscount.count).to eq(1)
        expect(current_path).to eq(new_merchant_discount_path)
        expect(page).to have_content("bulk_quantity: [\"is not a number\"]")
        expect(page).to have_content("percentage_discount: [\"Discount must be percentage from 1 - 100\"]")
      end

      it "Filling in the form with invalid information" do
        fill_in :bulk_quantity, with: -1
        fill_in :percentage_discount, with: 10
        click_button "Create Bulk Discount"

        expect(BulkDiscount.count).to eq(1)
        expect(current_path).to eq(new_merchant_discount_path)
        expect(page).to have_content("bulk_quantity: [\"must be greater than 0\"]")


        fill_in :bulk_quantity, with: 40
        fill_in :percentage_discount, with: -10
        click_button "Create Bulk Discount"

        expect(BulkDiscount.count).to eq(1)
        expect(current_path).to eq(new_merchant_discount_path)
        expect(page).to have_content("percentage_discount: [\"Discount must be percentage from 1 - 100\"]")
      end
    end
  end
end
