class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :schedule_session_timeout

  private

  def schedule_session_timeout
    if current_user
      begin
        Sidekiq::ScheduledSet.new
          .find_job(cookies.signed[:session_timeout_job_id])
          .reschedule(Devise.timeout_in.from_now)
      rescue
        job_id = UserSessionTimeoutJob.perform_in(Devise.timeout_in, current_user.id)
        cookies.signed[:session_timeout_job_id] = job_id
      end
    end
  end
end
