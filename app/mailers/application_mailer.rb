# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'hello@invoice.build'
  layout 'mailer'
end
