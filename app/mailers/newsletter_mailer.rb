class NewsletterMailer < ActionMailer::Base
  default from: "social@melbourneunibasketball.org.au"

  def distribute(newsletter_id, title, extra_recipients)
    #still need to define newsletter object

    Member.all.each do |member|
      mail(to: member.email, subject: 'MUBC Newsletter ')
    end
  end
end
