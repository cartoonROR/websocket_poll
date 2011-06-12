class Poll < ActiveRecord::Base
  has_many :sub_polls
end
