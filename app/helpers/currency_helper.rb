module CurrencyHelper
  def make_current_button event
    button_to "Mark as current", make_current_event_url(event)
  end

  def remove_current_button event
    button_to "Mark as done", remove_current_event_url(event)
  end

  def currency_button event
    if event.current?
      remove_current_button event
    else
      make_current_button event
    end
  end
end
