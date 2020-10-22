# frozen_string_literal: true

class SlackNotificationService
  attr_reader :notifier

  def initialize
    webhook_url = ENV.fetch('SLACK_INCOMING_WEBHOOK_URL', nil)
    @notifier = Slack::Notifier.new(webhook_url, channel: '#notifications', username: 'invoice.build')
  end

  def send(message)
    notifier.ping(message)
  end
end
