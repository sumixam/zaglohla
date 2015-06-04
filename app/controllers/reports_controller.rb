class ReportsController < ApplicationController

  def create
    @report = Report.new(report_params)
    @report.author_id = current_user.try(:id)
    @report.save
    render nothing: true
  end


  private

  def report_params
    params.require(:report).permit(:user_id, :description)
  end
end
