module Valid
  def valid?
    validate!
  rescue
    false
  end
end
