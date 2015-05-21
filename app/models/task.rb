class Task < ActiveRecord::Base
  belongs_to :user
  has_many :contexts
  has_many :projects
end
