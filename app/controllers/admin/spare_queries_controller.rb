class Admin::SpareQueriesController < Admin::ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /admin/users
  # GET /admin/users.json
  def index
    @spares = SpareQuery.order('attempts DESC').all
  end
end
