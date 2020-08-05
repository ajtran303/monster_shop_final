# Monster Shop Final

This is the repo for my Mod 2 Backend final project at the Turing School.

The objective is to add a "bulk discount" feature to an existing codebase for an e-commerce platform.

## Code Snippets

```ruby
# config/routes.rb

namespace :merchant do
  # ...
  resources :bulk_discounts, path: "discounts", as: :discounts, except: :show
end
```
![Screen Shot 2020-08-05 at 4 23 27 AM](https://user-images.githubusercontent.com/31839316/89402017-7229b180-d6d3-11ea-968c-bb2d2ef509a6.png)


```ruby
# Model logic

# app/models/bulk_discount.rb

def self.find_eligible_discount(item_quantity)
  order(:bulk_quantity).where("bulk_quantity <= ?", item_quantity).last
end

def calculate_discount(price)
  price * (100 - percentage_discount) * 0.01
end

# app/models/order_item.rb

def subtotal
  subtotal = quantity * price

  discounts = self.item.merchant.bulk_discounts
  discount = discounts.find_eligible_discount(quantity)

  discount ? discount.calculate_discount(subtotal) : subtotal
end

# app/models/order.rb

def grand_total
  order_items.sum(&:subtotal)
end
```

## Setup Instructions

### Easy mode
Go to the production site https://stormy-sands-63614.herokuapp.com/

### Hard Mode
First, set up a local server in your terminal:

```zsh
git clone git@github.com:ajtran303/monster_shop_final.git
cd monster_shop_final
bundle install
bundle exec rails db:{drop,create,migrate,seed}
rails s
```

Then, in your browser: go to `localhost:3000`

## How to use the Bulk Discount features

### Seeded Accounts:

Log in with one of these accounts; the password is `password`
```
rose_customer email: "rose@email.com"

megan_employee email: "meg@email.com"
brian_employee email: "brian@email.com"
```

### Seeded Discounts:

Both merchants offer percentage discounts for bulk purchases of a single item

```
Meg's discounts
20% discount for bulk of 5
25% discount for bulk of 10

Brian's discounts
30% discount for bulk of 10
```

### As an non-logged in visitor:
Visitors can add items to their shopping cart. The discount will apply and adjust in the cart when the item quantity qualifies for a discount for that merchant.

![Screen Shot 2020-08-05 at 4 04 12 AM](https://user-images.githubusercontent.com/31839316/89400163-bd8e9080-d6d0-11ea-9105-503fc3e23766.png)

### As Rose, the customer:
A logged-in customer can check out their cart to place an order. If a customer checks out with items that qualify for a discount, then the price will be reflected on the summary page for that order.

![Screen Shot 2020-08-05 at 4 05 05 AM](https://user-images.githubusercontent.com/31839316/89400254-de56e600-d6d0-11ea-9003-aade67a835af.png)


### As Megan or Brian, merchant employees:
When a merchant's employee is logged-in, they can see all of their bulk discounts by clicking a link on their dashboard. From the bulk discounts index page, they are able to create new discounts or update and destroy existing ones.

![Screen Shot 2020-08-05 at 3 55 18 AM](https://user-images.githubusercontent.com/31839316/89399731-14e03100-d6d0-11ea-8d03-fd1a0ef50c40.png)

![Screen Shot 2020-08-05 at 3 55 30 AM](https://user-images.githubusercontent.com/31839316/89399729-14e03100-d6d0-11ea-90ff-1e903e9695ae.png)

![Screen Shot 2020-08-05 at 3 55 47 AM](https://user-images.githubusercontent.com/31839316/89399728-14e03100-d6d0-11ea-9918-d4ad39b24340.png)

![Screen Shot 2020-08-05 at 3 55 54 AM](https://user-images.githubusercontent.com/31839316/89399725-14479a80-d6d0-11ea-8277-6f3bca917cdd.png)




## Completion Criteria (Completed)

1. Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.
1. You will implement a percentage based discount: 5% discount on 20 or more items
1. A merchant can have multiple bulk discounts in the system.
1. When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
1. A bulk discount from one merchant will only affect items from that merchant in the cart.
1. A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)
1. When there is a conflict between two discounts, the greater of the two will be applied.
1. Final discounted prices should appear on the orders show page.
