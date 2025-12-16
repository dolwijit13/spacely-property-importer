# frozen_string_literal: true

class PropertiesController < ApplicationController
  def index
    @properties = Property.page(params[:page]).per(10)
  end
end
