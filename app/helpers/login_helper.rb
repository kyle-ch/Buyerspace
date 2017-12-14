module LoginHelper
  def isEmail(str)
    return str.include? '@'
  end
end
