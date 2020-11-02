class UserSessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_session:#{current_user.id}"
  end
end