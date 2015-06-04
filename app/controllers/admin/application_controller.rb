class Admin::ApplicationController < ApplicationController
  before_filter :authenticate_administrator!
  layout "admin"
end
