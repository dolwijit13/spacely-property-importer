require 'rails_helper'

RSpec.describe ImportPropertyWorker, type: :worker do
  describe '#perform' do
    let(:file_path) { 'test_file.csv' }

    subject { described_class.new.perform(file_path) }

    it 'calls PropertyImporter with the given file path' do
      importer_instance = instance_double(PropertyImporter)
      expect(PropertyImporter).to receive(:new).with(file_path).and_return(importer_instance)
      expect(importer_instance).to receive(:call)

      subject
    end

    it 'removes the file after import' do
      allow(PropertyImporter).to receive(:new).and_return(instance_double(PropertyImporter, call: true))
      expect(FileUtils).to receive(:rm_f).with(file_path)

      subject
    end
  end
end