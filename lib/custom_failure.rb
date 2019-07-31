class CustomFailure < Devise::FailureApp
  def skip_format?
    %w[html pdf */*].include? request_format.to_s
  end
end
