require "rails_helper"

RSpec.describe "Edit Merchant Bulk Discount Spec" do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = create(:discount, merchant: @merchant1)
    @employee1 = create(:employee, merchant: @merchant1, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee1)
  end

  describe "As a merchant employee" do
    describe "on my bulk discount index page" do
      it "I can edit a discount by clicking the update link" do
        visit "/merchant/discounts"

        click_link 'Update Discount'

        expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
      end

      it 'I can edit the discount information' do
        quantity = 30
        percentage = 8

        visit "/merchant/discounts/#{@discount1.id}/edit"

        fill_in :bulk_quantity, with: quantity
        fill_in :percentage_discount, with: percentage
        click_button "Update Bulk Discount"

        expect(current_path).to eq("/merchant/discounts")
        expect(page).to have_content(quantity)
        expect(page).to have_content(percentage)
      end

      it 'I can not edit the item with an incomplete form' do
        visit "/merchant/discounts/#{@discount1.id}/edit"

        click_button 'Update Bulk Discount'

        expect(current_path).to eq("/merchant/discounts/#{@discount1.id}/edit")
        expect(page).to have_content("bulk_quantity: [\"is not a number\"]")
        expect(page).to have_content("percentage_discount: [\"Discount must be percentage from 1 - 100\"]")
        expect(page).to have_button('Update Bulk Discount')
      end
    end
  end
end
