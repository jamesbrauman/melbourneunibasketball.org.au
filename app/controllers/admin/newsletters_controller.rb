class Admin::NewslettersController < Admin::BaseController
  def email
    @newsletter = Newsletter.find params[:id]
  end

  def new
    @newsletter = Newsletter.new
  end

  def show
    @newsletter = Newsletter.find params[:id]
  end


  def index

  end

  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        format.html { redirect_to [:admin, @newsletter], notice: 'Newsletter was successfully created.' }
        format.json { render json: @newsletter, status: :created, location: @newsletter }
      else
        format.html { render action: "new" }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  def deliver
    NewsletterMailer.distribute(params[:id], params[:title], params[:extra_recipients]).deliver
    redirect_to admin_newsletters_path, flash: {notice: "Newsletter was successfully delivered."}
  end

  private
  def newsletter_params
#    params[:newsletter].only(:title, :author, :content)
    params[:newsletter]
  end
end
