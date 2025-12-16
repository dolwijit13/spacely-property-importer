# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PropertiesController, type: :controller do
  describe 'POST /api/properties/import', :perform_enqueued do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'properties.csv') }
    let(:uploaded_file) { fixture_file_upload(file_path, 'text/csv') }

    subject { post :import, params: { file: uploaded_file } }

    it 'returns a success message' do
      subject

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({ 'message' => 'Import successful' })
    end

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
  end
end
