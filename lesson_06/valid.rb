module Valid
  def valid?
    validate!
    true
  rescue
    false
  end
end
