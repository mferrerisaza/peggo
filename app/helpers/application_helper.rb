module ApplicationHelper
  def percentage(number)
    return if number.blank?
    "#{number * 100}%"
  end

  def status_color_class(debt)
    return "green-status" if debt.zero?
    "red-status"
  end
end
