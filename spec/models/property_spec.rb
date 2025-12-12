# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  describe 'validations' do
    subject { build(:property, { property_type: property_type }) }
    let(:property_type) { %i[house apartment condo].sample }

    it { should validate_presence_of(:unique_id) }
    it { should validate_uniqueness_of(:unique_id) }
    it { should validate_presence_of(:name) }

    context 'when property_type is house' do
      let(:property_type) { 'house' }

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

    %i[apartment condo].each do |property_type|
      include_examples 'room_number presence validation', property_type
    end
  end

  describe '#property_type_in_japanese' do
    subject { build(:property, property_type: property_type).property_type_in_japanese }

    context 'when property_type is apartment' do
      let(:property_type) { 'apartment' }
      it { is_expected.to eq 'アパート' }
    end

    context 'when property_type is house' do
      let(:property_type) { 'house' }
      it { is_expected.to eq '一戸建て' }
    end

    context 'when property_type is condo' do
      let(:property_type) { 'condo' }
      it { is_expected.to eq 'マンション' }
    end
  end
end
