class Secret < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { in: 5..75}


end
