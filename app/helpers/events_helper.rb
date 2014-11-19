module EventsHelper
  def event_row(event, &block)
    if event.current?
      content_tag :tr, class: 'active', &block
    else
      content_tag :tr, &block
    end
  end

  def toggle_event_button(event)
    if event.current?
      button_to 'Mark as done', remove_current_event_path(event)
    else
      button_to 'Mark as current', make_current_event_path(event)
    end
  end
end
