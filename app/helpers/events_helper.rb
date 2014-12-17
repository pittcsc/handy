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
      button_to 'Deactivate', deactivate_organization_event_path(@organization, event)
    else
      button_to 'Activate', activate_organization_event_path(@organization, event)
    end
  end
end
