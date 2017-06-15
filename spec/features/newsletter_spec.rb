require 'spec_helper'

feature "Newsletter Creation" do
  scenario "POST /admin/newsletters" do

    # check that the pdf is successfully uploaded to s3
    # check if the naming convention is satisfied
    # create cover image for the news item from pdf

    lambda {
      visit new_admin_newsletter_path
      fill_in "Title", :with => "Dribbling Balls 2017 - Volume 30 edition 2"
      fill_in "Author", :with => "adriansarstedt"
      fill_in "Content", :with => "Adrian updates the website!"
      attach_file "Newsletter PDF", "#{Rails.root.to_s}/spec/fixtures/2013_12_29_volume_029_issue_010.pdf/"
      click_button "Create Newsletter"
      page.should have_content("Newsletter was successfully created.")
      page.should have_content("Dribbling Balls 2017 - Volume 30 edition 2")
    }.should change(NewsItem.dribbling_balls, :count).by(1)
  end
end
#  email_admin_newsletter GET    /admin/newsletters/:id/email(.:format)           admin/newsletters#email
#   send_admin_newsletter POST   (.:format)            admin/newsletters#send

feature "Newsletter Sending" do
  let(:jan_31_2012){ Date.new(2012,  1, 31) }
  let(:mar_31_2013){ Date.new(2013,  3, 31) }
  let(:dec_31_2013){ Date.new(2013, 12, 31) }
  let(:jan_31_2015 ){ Date.new(2015, 1,  31) }

  let!(:jan_31_2012_member){ Member.make!(created_at: jan_31_2012, payment_confirmed: true, amount_paid: 130, email: "2012_member@gmail.com") }
  let!(:mar_31_2013_member){ Member.make!(created_at: mar_31_2013, payment_confirmed: true, amount_paid: 0,   email: "2013_member_1@gmail.com") }
  let!(:dec_31_2013_member){ Member.make!(created_at: dec_31_2013, payment_confirmed: true, amount_paid: 130, email: "2013_member_2@gmail.com") }
  let!(:jan_31_2015_member){ Member.make!(created_at: jan_31_2015, payment_confirmed: true, amount_paid: 130, email: "2015_member@gmail.com") }


  let(:newsletter){ Newsletter.make }

  scenario "POST /admin/newsletters/:id/send" do
    context "when we check the box to send to current members" do
      Timecop.freeze(mar_31_2013) do
        expect(NewsletterMailer).to(receive(:deliver_signup).with(
          newsletter.id,
          'MUBC Newsletter - Trivia Night 2017',
          ["someone@somewhere.com", "someoneelse@somewhere.com", "2013_member_1@gmail.com", "2013_member_2@gmail.com"]
        ))
        visit email_admin_newsletter(newsletter.id)
        check 'Send to all current members'
        fill_in "Extra Recipients", with: "someone@somewhere.com,someoneelse@somewhere.com"
        fill_in "Title", with: "Trivia Night 2017"  # ie. title will be 'MUBC Newsletter - Trivia Night 2017'
        click_button "Create Newsletter"
      end
    end

    # emails should only go to current members
    # emailing a newsletter should only be available on a newsletter edit screen if it hasn't been sent before
    # we should be able to modify the body of the email that is sent
    # the newsletters admin list should show the sent date if a newsletter has been emailed to memebers
    # field to add extra bcc recipients
    # should always bcc the committee@melbourneunibasketball.org.au
    # email should be sent from social@melbourneunibasketball.org.au
    # email body should contain an inline image of the cover of the newsletter and that should link to the amazon s3 url
    # email should also have an attachment of the pdf document itself
    # email title should contain MUBC Newsletter - "field that they can enter"
    # only a super-admin can share newsletter through email
    # there should also be a checkbox option for 'publish to facebook'
  end
end
