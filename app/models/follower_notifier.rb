class FollowerNotifier

  def initialize(user)
    @user = user
  end

  def notify(subject, target, type)
    user.followers.each do |follower|
      follower.activities.create(
        actor: user,
        subject: subject,
        type: type,
        target: target
      )
    end
  end
#  handle_asynchronously :notify

  private
  attr_reader :user

  

end