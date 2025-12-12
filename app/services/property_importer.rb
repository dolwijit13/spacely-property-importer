# frozen_string_literal: true

class PropertyImporter
  BATCH_SIZE = 1_000

  def initialize(file)
    @file = file
  end

  def call
    data_to_upsert = []
    CSV.foreach(@file, headers: true) do |row|
      data_to_upsert << parse_row(row)

      if data_to_upsert.size >= BATCH_SIZE
        upsert_data(data_to_upsert)
        data_to_upsert = []
      end
    end

    upsert_data(data_to_upsert)
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

  def upsert_data(data)
    return if data.empty?

    Property.upsert_all(data)
  end
end
