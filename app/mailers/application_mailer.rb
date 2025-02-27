# frozen_string_literal: true

# basic application mailer
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
