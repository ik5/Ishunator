class AdminUser < ActiveRecord::Base

  def password=(pass)
    self.password = phash(pass)
  end

  def self.phash(pass)
    Digest::SHA1.hexdigest(pass)
  end

  def self.credentials(username, password)
    find_by_username_and_password(username, phash(password))
  end

  def self.auth?(username, password)
    credentials(username, password) != nil
  end
end
