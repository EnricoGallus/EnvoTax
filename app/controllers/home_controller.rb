# frozen_string_literal: true

# default controller for the root path
class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index; end
end
