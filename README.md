# Monster Shop Final

This is the repo for my Mod 2 Backend final project at the Turing School.

The objective is to add a "bulk discount" feature to an existing codebase for an e-commerce platform.

I did this 

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

### As Rose, the customer:
A logged-in customer can check out their cart to place an order. If a customer checks out with items that qualify for a discount, then the price will be reflected on the summary page for that order.

### As Megan or Brian, merchant employees:
When a merchant's employee is logged-in, they can see all of their bulk discounts by clicking a link on their dashboard. From the bulk discounts index page, they are able to create new discounts or update and destroy existing ones.

## Completion Criteria (Completed)

1. Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.
1. You will implement a percentage based discount:
   - 5% discount on 20 or more items
1. A merchant can have multiple bulk discounts in the system.
1. When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
1. A bulk discount from one merchant will only affect items from that merchant in the cart.
1. A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)
1. When there is a conflict between two discounts, the greater of the two will be applied.
1. Final discounted prices should appear on the orders show page.
