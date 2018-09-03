module ApplicationHelper
  def percentage(number)
    return if number.blank?
    "#{number * 100}%"
  end
end
