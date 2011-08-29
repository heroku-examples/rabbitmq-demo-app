require 'sinatra/base'
require 'lib/sinatra_rabbitmq'

class RabbitmqDemo < Sinatra::Base
  register Sinatra::RabbitMQ

  get "/" do
    haml :index
  end

  post "/" do
    self.class.rabbitmq_exchange.publish params["message"], :key => "messages"
    @notice = "Message has been published."
    haml :index
  end

  get "/message" do
    msg = self.class.rabbitmq_messages_queue.pop
    if msg[:payload] == :queue_empty
      @notice = "No more messages."
    else
      @message = msg[:payload]
    end
    haml :index
  end
end
