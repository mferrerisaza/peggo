module PropertiesTableHelper
  def property_owners(owners_array)
    owners_array.map(&:name).join(", ")
  end

  def no_owners?(owners_array)
    return true if owners_array.blank?
    false
  end
end
