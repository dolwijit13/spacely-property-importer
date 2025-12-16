class ImportPropertyWorker
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform(file_path)
    PropertyImporter.new(file_path).call
    FileUtils.rm_f(file_path)
  end
end
