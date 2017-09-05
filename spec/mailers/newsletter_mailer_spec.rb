require "spec_helper"

describe NewsletterMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  describe "#newsletter" do
    context "when an ios Device is associated with the email address" do
      let(:newsletter){ Newsletter.make }
      let(:mail){
        NewsletterMailer.distribute(
          newsletter.id,
          'MUBC Newsletter - Trivia Night 2017',
          [ "someoneelse@somewhere.com" ]
        )
      }
      specify{ expect(mail).to deliver_to("someoneelse@somewhere.com") }
      specify{ expect(mail).to deliver_from("Social Coordinator at Melbourne Uni Basketball <#{ENV[:NEWSLETTER_SENDER]}>") }
      specify{ expect(mail.subject).to eq("MUBC Newsletter - Trivia Night 2017") }
      specify{ expect(mail).to have_body_text(/Hey there, ..../) }
      specify{ expect(mail.body.parts.length).to eq(2) }
      specify{ expect(mail.body.parts.collect(&:content_type)).to eq(["text/plain; charset=UTF-8", "text/html; charset=UTF-8"]) }
    end
  end
end
