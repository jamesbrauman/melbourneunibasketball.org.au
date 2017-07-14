class NewsletterMailer < ActionMailer::Base
  default from: "social@melbourneunibasketball.org.au"

  def newsletter_email(user, newletter)
    #still need to define newsletter object
    @user = user
    mail(to: @user.email, subject: 'MUBC Newsletter ' + newletter.name)
  end
end
