class User < ActiveRecord::Base
  has_secure_password

  email_regex = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  before_save :downcase
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: email_regex }


  def downcase
    self.email.downcase!
    self.name.downcase!
  end

end
