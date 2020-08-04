require "rails_helper"

RSpec.describe "Merchant Bulk Discount Index Page Spec" do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = create(:discount, merchant: @merchant1, bulk_quantity: 10, percentage_discount: 5)
    @discount2 = create(:discount, merchant: @merchant1, bulk_quantity: 20, percentage_discount: 10)
    @employee1 = create(:employee, role: 1, merchant: @merchant1)

    @merchant2 = create(:merchant)
    @employee2 = create(:employee, role: 1, merchant: @merchant2)
  end

  describe "As a merchant employee" do
    describe "When I visit my merchant dashboard" do
      it "I can click a link to my bulk discounts index page" do
        [@employee1, @employee2].each do |employee|
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(employee)

          visit merchant_dashboard_path
          expect(page).to have_link("My Bulk Discounts", href: "/merchant/discounts")

          click_link("My Bulk Discounts")
          expect(current_path).to eq("/merchant/discounts")
          expect(page).to have_content("All My Bulk Discounts")
        end
      end
    end

    describe "When I visit my bulk discounts index page" do
      describe "If I have discounts" do
        it "I see a list of all my discounts and their details" do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee1)
          visit merchant_discounts_path

          [@discount1, @discount2].each do |discount|
            within ".discount-#{discount.id}" do
              expect(page).to have_content("Quantity: #{discount.bulk_quantity}")
              expect(page).to have_content("Discount: #{discount.percentage_discount}%")
              expect(page).to have_content("Created At: #{discount.created_at.to_s(:short)}")
            end
          end
        end
      end

      describe "If I do not have discounts" do
        it "I see a message that says I have not added any discounts yet" do
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@employee2)
          visit merchant_discounts_path

          expect(page).to have_content("You haven't added any bulk discounts yet.")
        end
      end
    end
  end
end
