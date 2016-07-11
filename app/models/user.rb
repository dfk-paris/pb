require 'digest'

class User < ApplicationRecord

  def self.authenticate(username, password)
    if Rails.env.development?
      where(username: username).first
    else
      where(username: username, password: crypt(password)).first
    end
  end

  def password=(value)
    self[:password] = self.class.crypt(value)
  end

  def self.crypt(str)
    Digest::SHA2.hexdigest(str)
  end

end
