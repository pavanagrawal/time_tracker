class ReportsController < ApplicationController

  layout false
  def index
    @current_week_projects = current_user.current_week_projects
  end
end
