module EventsHelper
  def event_row(event, &block)
    if event.active?
      content_tag :tr, class: 'active', &block
    else
      content_tag :tr, &block
    end
  end

  def toggle_event_button(event)
    if event.active?
      button_to 'Deactivate', deactivate_event_path(event)
    else
      button_to 'Activate', activate_event_path(event)
    end
  end
end
