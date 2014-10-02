class AttendancesController < ApplicationController
  def index
    @events = Event.all
    @attendance = Attendance.all
  end
end
