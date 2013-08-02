module Zomburl
  def self.has_captcha?
    begin
      !CAPTCHA_PUBLIC_KEY.empty? && !CAPTCHA_PRIVATE_KEY.empty?
    rescue
      false
    end
  end
end
