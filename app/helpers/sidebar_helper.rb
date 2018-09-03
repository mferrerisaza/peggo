module SidebarHelper
  def render_blue_sidebar
    allowed_controllers = {
      buildings: %w[show],
      properties: %w[index show new create edit update],
      owners: %w[index show],
      shares: %w[create update]
    }
    return if allowed_controllers[controller_name.to_sym].nil?
    allowed_controllers[controller_name.to_sym].include?(action_name)
  end
end
