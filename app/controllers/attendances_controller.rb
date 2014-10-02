class AttendancesController < ApplicationController
  before_action :set_event
  def index
    @attendances = @event.attendances.all
  end

  def new
    @attendance = Attendance.new
  end

  def create
    attendance_params = params[:attendance]
    event_id = attendance_params[:event_id]
    member_id = attendance_params[:member_id]

    attendance = Attendance.create(event_id: event_id, member_id: member_id)

    event.save

    # Redirect to specific attendance page
    redirect_to events_url
  end

  def show
    attendance_id = params[:id]
    @attendance = Attendance.find(attendance_id)
  end

  def edit
    attendance_id = params[:id]

    @attendance = Attendance.find(attendance_id)
  end

  def update
    attendance_id = params[:id]
    event_id = params[:event_id]
    member_id = params[:member_id]

    attendance = Attendance.find(attendance_id)

    attendance.event_id = event_id
    attendance.member_id = member_id

    attendance.save

    redirect_to events_url
  end

  def destroy
    attendance_id = params[:id]
    Attendance.destroy(attendance_id)

    redirect_to events_url
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
end
