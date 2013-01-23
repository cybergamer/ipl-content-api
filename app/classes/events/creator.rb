module Events
  class Creator

    def create(data, options = {})
      data_handler = options[:data_handler] || Events::Data::Handler.new
      event = Event.create(data_handler.handle(data, options))
      if event.persisted?
        after_create(event, options)
        event.reload
      else
        event
      end
    end

    def after_create(event, options = {})
    end

  end
end