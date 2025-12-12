# frozen_string_literal: true

class PropertyImporter
  def initialize(file)
    @file = file
  end

  def call
    data_to_upsert = []
    CSV.foreach(@file, headers: true) do |row|
      data_to_upsert << parse_row(row)
    end

    Property.upsert_all(data_to_upsert)
  end

private

  def parse_row(row)
    {
      unique_id: row['ユニークID'].to_i,
      name: row['物件名'],
      room_number: row['部屋番号'].to_i,
      address: row['住所'],
      rent: row['賃料'].to_i,
      size: row['広さ'].to_f,
      property_type: row['建物の種類']
    }
  end
end
