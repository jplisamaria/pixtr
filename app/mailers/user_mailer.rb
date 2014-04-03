class UserMailer < ActionMailer::Base
  default from: "from@example.com"

    def welcome_email(user, activity)
      @user = user
      mail(to: @user.email, subject: 'You have user activity.')
  end


end
