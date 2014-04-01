class CreateImageActivity < Activity
  def image
    target
  end

  def email
    actor.email
  end

  def image_name
    target.name
  end
end