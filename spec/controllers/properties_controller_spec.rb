# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  describe 'GET /properties' do
    subject { get :index }

    let(:properties) { create_list(:property, 2) }

    it 'returns a success response' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'assigns all properties to @properties' do
      subject

      expect(assigns(:properties)).to match_array(properties)
    end

    it 'renders the index template' do
      subject

      expect(response).to render_template(:index)
    end

    it 'paginates the properties' do
      create_list(:property, 15)

      get :index, params: { page: 2 }

      expect(assigns(:properties).size).to eq(5)
    end
  end
end
