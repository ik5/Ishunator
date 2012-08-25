class AdminUser < ActiveRecord::Base

  def pass=(pass)
    self.password = Digest::SHA1.hexdigest(pass)
  end

  def self.credentials(username, password)
    find_by_username_and_password(username, Digest::SHA1.hexdigest(password))
  end

  def self.auth?(username, password)
    find_by_username_and_password(username, Digest::SHA1.hexdigest(password)) != nil
  end
end
