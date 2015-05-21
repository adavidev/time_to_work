class Task < ActiveRecord::Base
  belongs_to :user
  has_many :contexts
  has_many :projects

  scope :not_done, -> {where("done is null or done = 0")}
  scope :done, -> {where("done = 1")}

end
