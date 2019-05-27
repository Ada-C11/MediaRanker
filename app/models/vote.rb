class Vote < ApplicationRecord
  belongs_to :user, :work
end
