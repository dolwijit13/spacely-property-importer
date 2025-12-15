# frozen_string_literal: true

module Api
  class PropertiesController < ApplicationController
    def import
      PropertyImporter.new(params[:file].path).call
      render json: { message: 'Import successful' }, status: :ok
    end
  end
end
