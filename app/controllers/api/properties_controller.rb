# frozen_string_literal: true

module Api
  class PropertiesController < ApplicationController
    def import
      storage_path = Rails.root.join('tmp', 'uploads', "#{SecureRandom.uuid}_#{params[:file].original_filename}").to_s
      FileUtils.mkdir_p(File.dirname(storage_path))
      File.open(storage_path, 'wb') do |file|
        file.write(params[:file].read)
      end
      ImportPropertyWorker.perform_async(storage_path)
      render json: { message: 'Import successful' }, status: :created
    end
  end
end
