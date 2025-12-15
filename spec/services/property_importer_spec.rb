# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertyImporter, type: :service do
  describe '#call' do
    let(:csv_file_path) { Rails.root.join('spec', 'fixtures', 'files', 'properties.csv') }
    let(:csv_file) { fixture_file_upload(csv_file_path, 'text/csv') }

    subject { described_class.new(csv_file).call }

    context 'with valid CSV data' do
      it 'imports all properties from the CSV file' do
        expect { subject }.to change(Property, :count).by(3)
      end

      it 'creates properties with correct attributes' do
        subject

        property_1 = Property.find_by(unique_id: 1)
        expect(property_1).to have_attributes(
          name: 'シーサイドアパート',
          address: '福岡県福岡市94-31',
          room_number: 830,
          rent: 188_000,
          size: 91.0,
          property_type: 'apartment'
        )
      end

      context 'when properties already exist' do
        before do
          create(:property, unique_id: 1, name: 'Old Name', address: 'Old Address', room_number: 1, rent: 100_000,
                            size: 50.0, property_type: :house)
        end

        it 'updates existing properties' do
          subject

          updated_property = Property.find_by(unique_id: 1)
          expect(updated_property).to have_attributes(
            name: 'シーサイドアパート',
            address: '福岡県福岡市94-31',
            room_number: 830,
            rent: 188_000,
            size: 91.0,
            property_type: 'apartment'
          )
        end
      end
    end
  end
end
