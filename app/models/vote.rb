class Vote < ApplicationRecord
  belongs_to :work, :user
end
