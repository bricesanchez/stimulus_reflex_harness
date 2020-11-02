class UserSessionTimeoutJob
  include Sidekiq::Worker
  include CableReady::Broadcaster

  def perform(current_user_id)
    cable_ready["user_session:#{current_user_id}"].dispatch_event(
      name: "user-session:timedout",
      detail: { message: "User session is expired" }
    )
    cable_ready.broadcast
  end
end