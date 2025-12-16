# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'validations' do
    subject { create(:property, property_type: property_type) }
    let(:property_type) { %w[アパート 一戸建て マンション].sample }

    it { should validate_presence_of(:unique_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:property_type) }

    context 'when property_type is 一戸建て' do
      let(:property_type) { '一戸建て' }

      it 'does not validate presence of room_number' do
        expect(subject).to allow_value(nil).for(:room_number)
      end
    end

    shared_examples 'room_number presence validation' do |property_type|
      context "when property_type is #{property_type}" do
        let(:property_type) { property_type.to_s }

        it 'validates presence of room_number' do
          expect(subject).to validate_presence_of(:room_number)
        end
      end
    end

    %w[アパート マンション].each do |property_type|
      include_examples 'room_number presence validation', property_type
    end
  end

  describe '#house?' do
    subject { build(:property, property_type: property_type).house? }

    context 'when property_type is アパート' do
      let(:property_type) { 'アパート' }
      it { is_expected.to eq false }
    end

    context 'when property_type is 一戸建て' do
      let(:property_type) { '一戸建て' }
      it { is_expected.to eq true }
    end

    context 'when property_type is マンション' do
      let(:property_type) { 'マンション' }
      it { is_expected.to eq false }
    end
  end
end
