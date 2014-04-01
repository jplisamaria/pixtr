class CreateGalleryActivity < Activity
  def gallery
    target
  end

  def email
    actor.email
  end

  def gallery_name
    target.name
  end
end