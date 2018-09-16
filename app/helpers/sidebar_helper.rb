module SidebarHelper
  def render_blue_sidebar
    allowed_controllers = {
      buildings: %w[show],
      properties: %w[index show new create edit update],
      owners: %w[index show new create edit update],
      shares: %w[create update],
      bills: %w[new create errors],
      budgets: %w[index new create edit update]
    }
    return if allowed_controllers[controller_name.to_sym].nil?
    allowed_controllers[controller_name.to_sym].include?(action_name)
  end
end
