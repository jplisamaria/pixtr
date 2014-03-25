class CreateGalleryActivity < Activity
  def gallery
    subject
  end

  def email
    subject.user.email
  end

  def gallery_name
    subject.name
  end
end