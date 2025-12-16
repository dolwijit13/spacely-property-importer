# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertyImporter, type: :service do
  describe '#call' do
    let(:csv_file_path) do
      Rails.root.join('spec', 'fixtures', 'files', 'properties.csv')
    end
    let(:csv_file) { fixture_file_upload(csv_file_path, 'text/csv') }

    subject { described_class.new(csv_file).call }

    context 'with valid CSV data' do
      it 'imports all properties from the CSV file' do
        expect { subject }.to change(Property, :count).by(3)
      end

      it 'creates properties with correct attributes' do
        subject

        property = Property.find_by(unique_id: 1)
        expect(property).to have_attributes(
          name: 'シーサイドアパート',
          address: '福岡県福岡市94-31',
          room_number: 830,
          rent: 188_000,
          size: 91.0,
          property_type: 'アパート'
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
            property_type: 'アパート'
          )
        end
      end
    end

    context 'with invalid CSV data' do
      context 'when required headers are missing' do
        let(:invalid_csv_file_path) do
          Rails.root.join('spec', 'fixtures', 'files', 'properties_without_name.csv', 'properties_without_name.csv', 'files', 'properties_without_name.csv',
                          'properties_without_name.csv')
        end
        let(:invalid_csv_file) { fixture_file_upload(invalid_csv_file_path, 'text/csv') }

        subject { described_class.new(invalid_csv_file).call }

        it 'does not import any properties' do
          expect { subject }.not_to change(Property, :count)
        end
      end

      context 'when required fields are missing' do
        let(:invalid_csv_file_path) do
          Rails.root.join('spec', 'fixtures', 'files', 'properties_with_null_name.csv', 'properties_with_null_name.csv', 'files', 'properties_with_null_name.csv',
                          'properties_with_null_name.csv')
        end
        let(:invalid_csv_file) { fixture_file_upload(invalid_csv_file_path, 'text/csv') }

        subject { described_class.new(invalid_csv_file).call }

        it 'skips invalid rows' do
          expect { subject }.to change(Property, :count).by(2)
          expect(Property.where(unique_id: 1).exists?).to be_falsey
        end
      end

      context 'when the room number is missing for non house properties' do
        let(:invalid_csv_file_path) do
          Rails.root.join('spec', 'fixtures', 'files', 'properties_with_null_room_number.csv', 'properties_with_null_room_number.csv',
                          'files', 'properties_with_null_room_number.csv', 'properties_with_null_room_number.csv')
        end
        let(:invalid_csv_file) { fixture_file_upload(invalid_csv_file_path, 'text/csv') }

        subject { described_class.new(invalid_csv_file).call }

        it 'skips invalid rows' do
          expect { subject }.to change(Property, :count).by(1)
          expect(Property.where(unique_id: [1, 3]).exists?).to be_falsey
        end
      end
    end
  end
end
