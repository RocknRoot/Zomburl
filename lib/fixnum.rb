class Fixnum
  BASE_32 = ["0","1","2","3","4","5","6","7","8",
             "9","A","B","C","D","E","F","G","H",
             "I","J","K","L","M","N","O","P","Q",
             "R","S","T","U","V","W","X","Y","Z"]

  def to_32
    number = ""
    current = self
    return "0" if self == 0
    while current != 0
      number  << BASE_32[current % 32]
      current = current / 32
    end
    return number.reverse
  end

end ## Fixnum
