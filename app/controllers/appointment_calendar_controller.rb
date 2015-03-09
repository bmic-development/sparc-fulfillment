class AppointmentCalendarController < ApplicationController

  def complete_procedure
    @procedure = Procedure.find(params[:procedure_id])
    @procedure.update_attributes(status: "complete", completed_date: Time.now, reason: nil)
    Note.create(procedure_id: @procedure.id, user_id: current_user.id, user_name: current_user.full_name, comment: "Set to completed")
  end

  def edit_incomplete_procedure
    @procedure = Procedure.find(params[:procedure_id])
    @note = Note.new
  end

  def update_incomplete_procedure
    reason = params[:procedure][:reason]
    comment = params[:note][:comment]
    comment = comment.blank? ? reason : reason + " - " + comment

    @procedure = Procedure.find(params[:procedure_id])
    @procedure.update_attributes(status: "incomplete", reason: reason)

    Note.create(procedure_id: @procedure.id, comment: comment, user_id: current_user.id, user_name: current_user.full_name)
  end

  def edit_follow_up
    @procedure = Procedure.find(params[:procedure_id])
    @note = Note.new
  end

  def update_follow_up
    @procedure = Procedure.find(params[:procedure_id])
    @date = params[:procedure][:follow_up_date]
    @has_date = @date.length > 0

    if @has_date or not @procedure.follow_up_date.blank?
      @procedure.update_attributes(follow_up_date: @date)
      if @has_date
        end_comment = "Follow Up - #{@date}"
      else
        end_comment = "Follow Up Date Removed"
      end
      end_comment += " - #{params[:note][:comment]}" if params[:note][:comment].length > 0
      Note.create(procedure: @procedure, user_id: current_user.id, user_name: current_user.full_name, comment: end_comment)
    end
  end

end