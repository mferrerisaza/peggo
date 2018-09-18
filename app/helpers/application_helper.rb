module ApplicationHelper
  def percentage(number)
    return if number.blank?
    "#{number * 100}%"
  end

  def status_color_class(debt)
    return "green-status" if debt.zero?
    "red-status"
  end

  def group_bills_by_period(bills)
    bills.group_by { |bill| bill.period }.sort.reverse!.to_h
  end

  def amount_by_bill_period(bills)
    bills.reduce(0) { |sum, bill| sum + bill.sum_concepts_amount }
  end

  def order_by_period(bills)
    bills.sort_by { |period| period }
  end
end
