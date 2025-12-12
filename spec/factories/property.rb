FactoryBot.define do
  factory :property do
    sequence(:unique_id)
    name { 'property_name' }
    property_type { %i[house apartment condo].sample }
    room_number { property_type == 'house' ? nil : (101..999).to_a.sample }
    address { 'address' }
    rent { (50_000..150_000).to_a.sample }
    size { (20..150).to_a.sample }
  end
end
