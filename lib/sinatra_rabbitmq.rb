require 'sinatra/base'
require 'bunny'

module Sinatra
  module RabbitMQ
    def rabbitmq_client
      return @rabbitmq_client if @rabbitmq_client
      @rabbitmq_client = Bunny.new(ENV["RABBITMQ_URL"])
      @rabbitmq_client.start
      @rabbitmq_client
    end

    def rabbitmq_exchange
      @rabbitmq_exchange ||= rabbitmq_client.exchange("")
    end

    def rabbitmq_messages_queue
      @rabbitmq_messages_queue ||= rabbitmq_client.queue("messages")
    end
  end

  register RabbitMQ
end

