# frozen_string_literal: true

require 'csv'

class PropertyImporter
  BATCH_SIZE = 1_000

  def initialize(file)
    @file = file
  end

  def call
    data_to_upsert = []
    CSV.foreach(@file, headers: true) do |row|
      parsed_row = parse_row(row)
      next unless validate_row(parsed_row)

      data_to_upsert << parsed_row

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
      unique_id: row['ユニークID'] ? row['ユニークID'].to_i : nil,
      name: row['物件名'],
      room_number: row['部屋番号'] ? row['部屋番号'].to_i : nil,
      address: row['住所'],
      rent:  row['賃料'] ? row['賃料'].to_i : nil,
      size: row['広さ'] ? row['広さ'].to_f : nil,
      property_type: row['建物の種類']
    }
  end

  def validate_row(parsed_row)
    Property.new(parsed_row).valid?
  end

  def upsert_data(data)
    return if data.empty?

    Property.import(data, on_duplicate_key_update: :all, conflict_target: :unique_id)
  end
end
