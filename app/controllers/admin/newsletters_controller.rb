class Admin::NewslettersController < Admin::PagesController
  def email
    @newsletter = Newsletter.find params[:id]
  end

end
