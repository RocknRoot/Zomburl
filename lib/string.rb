require 'mhash'

class String

  def to_crc
    Mhash.crc32b!(self)
  end

end # String
