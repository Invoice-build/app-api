# frozen_string_literal: true

class Invoice::OnCreatedJob < ApplicationJob
  def perform(invoice_id)
    slack_service.send("*Event*: New Invoice\n*ID*: #{invoice_id}")
  end

  private

  def slack_service
    @slack_service ||= SlackNotificationService.new
  end
end
