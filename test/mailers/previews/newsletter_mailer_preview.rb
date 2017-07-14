class NewsletterMailerPreview < ActionMailer::Preview
  def newsletter_mail_preview
    NewsletterMailer.newsletter_email(Member.first)
  end
end
