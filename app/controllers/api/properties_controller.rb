# frozen_string_literal: true

module Api
  class PropertiesController < ApplicationController
    def import
      storage_path = File.join(Rails.root, 'tmp', 'uploads', "#{SecureRandom.uuid}_#{params[:file].original_filename}")
      FileUtils.cp(params[:file].path, storage_path)
      ImportPropertyWorker.perform_async(storage_path)
      render json: { message: 'Import successful' }, status: :created
    end
  end
end
