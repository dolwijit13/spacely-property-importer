# frozen_string_literal: true

class Property < ApplicationRecord
  module PropertyTypes
    APARTMENT = 'アパート'
    HOUSE = '一戸建て'
    CONDO = 'マンション'
  end

  enum property_type: {
    apartment: PropertyTypes::APARTMENT,
    house: PropertyTypes::HOUSE,
    condo: PropertyTypes::CONDO
  }

  validates :unique_id, presence: true
  validates :name, presence: true
  validates :property_type, presence: true
  validates :room_number, presence: true, unless: :house?

  def property_type_in_japanese
    self.class.property_types[self[:property_type]]
  end
end
