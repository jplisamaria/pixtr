class FollowSomeoneActivity < Activity
  def followed_user
    target
  end

  def followed_user_name
    target.email
  end

  def email
    actor.email
  end

end