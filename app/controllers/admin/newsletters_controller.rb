class Admin::NewslettersController < Admin::BaseController
  def email
    @newsletter = Newsletter.find params[:id]
  end

  def new
    @newsletter = Newsletter.new
  end

  def index

  end

  def create
    Newsletter.create(title: "params[:title]")
    puts "//////////////Newsletter Created///////////"
    puts params
  end

  def deliver
    NewsletterMailer.distribute(params[:id], params[:title], params[:extra_recipients]).deliver
    redirect_to admin_newsletters_path, flash: {notice: "Newsletter was successfully delivered."}
  end
end
