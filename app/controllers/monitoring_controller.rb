class MonitoringController < ApplicationController
  skip_authentication

  def up
    head :ok
  end
end
