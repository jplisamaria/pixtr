class LikeActivity < Activity
  def likable
    target
  end

  def likable_type
    target_type
  end

  def likable_name
    target.name
  end

  def email
    actor.email
  end
end