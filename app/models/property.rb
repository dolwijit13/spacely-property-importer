# frozen_string_literal: true

class Property < ApplicationRecord
  module PropertyTypes
    APARTMENT = 'アパート'
    HOUSE = '一戸建て'
    CONDO = 'マンション'
  end

  validates :unique_id, presence: true
  validates :name, presence: true
  validates :property_type, presence: true
  validates :room_number, presence: true, unless: :house?

  def house?
    property_type == PropertyTypes::HOUSE
  end
end
