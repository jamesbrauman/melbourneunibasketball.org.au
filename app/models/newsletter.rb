class Newsletter < Page
  # validates_presence_of :cover_image, :url, :has_been_distributed

  attr_accessor :send_to_all_current_members, :extra_recipients
end
