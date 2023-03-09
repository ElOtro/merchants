class V1::BaseController < ApplicationController
  include ::Auth::Session
  before_action :authenticate_request
end
