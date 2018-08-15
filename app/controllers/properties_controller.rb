class PropertiesController < ApplicationController
  def index
    @properties = policy_scope(Property)
  end
end
