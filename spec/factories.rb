FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Dessert.variety}
  end

  factory :invoice do
    status {[0,1,2].sample}
    merchant
    customer
  end

  factory :merchant do
    name {Faker::Space.galaxy}
    invoices
    items
  end

  factory :item do
    name {Faker::Coffee.variety}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Finance.credit_card}
    invoice
  end

  factory :invoice_item do
    status {[0,1,2].sample}
    merchant
    invoice
  end

  # factory :coupon do
  #   coupon_name {Faker::FunnyName.name }
  #   coupon_code {Faker::Commerce.promotion_code }
  #   status {[0,1].sample}
  #   discount_amount {Faker::Commerce.price(range: 0..75.0) }
  #   discount_type {[0,1].sample}
  #   merchant
  # end
end
