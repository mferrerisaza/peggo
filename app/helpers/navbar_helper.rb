module NavbarHelper
  def navbar_color
    if controller_name == "pages" && action_name == "home"
      "navbar-wagon-transparent"
    else
      "navbar-wagon-blue"
    end
  end

  def do_not_render_navbar_web
    return "hidden-md hidden-lg" if render_blue_sidebar
  end

  def render_navbar_dropdown
    allowed_controllers = {
      buildings: %w[index],
      pages: %w[home]
    }
    return false if allowed_controllers[controller_name.to_sym].nil?
    allowed_controllers[controller_name.to_sym].include?(action_name)
  end
end
