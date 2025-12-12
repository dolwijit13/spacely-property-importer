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

  def property_type_in_japanese
    self.class.property_types[self[:property_type]]
  end
end
