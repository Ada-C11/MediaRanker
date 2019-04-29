class Work < ApplicationRecord
  validates :title, presence: :true
  has_and_belongs_to_many :users

  def self.top_ten(category)
    selected_works = Work.where(category: category)

    ordered_works = selected_works.sort_by do |work|
      work.users.length
    end

    ordered_works.reverse!

    until ordered_works.length <= 10
      ordered_works.pop
    end

    return ordered_works
  end

  def self.featured
    all_works = Work.all
    return all_works.max_by { |work| work.users.length }
  end
end
