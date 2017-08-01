class NewsletterMailer < ActionMailer::Base
  default from: "social@melbourneunibasketball.org.au"

  def distribute(newsletter_id, title, extra_recipients)
    #still need to define newsletter object
    mail(to: @user.email, subject: 'MUBC Newsletter ' + newletter.name)
  end
end
