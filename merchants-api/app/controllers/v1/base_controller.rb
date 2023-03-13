# frozen_string_literal: true

module V1
  class BaseController < ApplicationController
    include ::Auth::Admin
    before_action :authenticate_request
  end
end
