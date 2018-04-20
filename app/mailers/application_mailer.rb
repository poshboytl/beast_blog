class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@small.com'
  layout 'mailer'

  def set_logo_url
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/src/images/logo.png")
  end
end
