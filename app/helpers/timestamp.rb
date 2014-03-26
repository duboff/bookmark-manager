helpers do
  def too_late?(time_string)
    time = time_string.to_i
    time_1_hour_ago = Time.now - (60*60)
    time > time_1_hour_ago.to_i
  end
end
