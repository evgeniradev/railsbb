class Post < ApplicationRecord
  include CacheManagement
  after_commit -> { delete_sections_cache :sections }

  belongs_to :section
  belongs_to :forum
  belongs_to :topic
  belongs_to :user
  enum kind: { standard: 0, primary: 1 }

  validates :content, presence: true
  validates :content, length: { maximum: 10_000 }

  def self.search(input)
    joins(:topic).where(
      'posts.content LIKE ? OR topics.title LIKE ? AND posts.kind=1',
      "%#{input}%",
      "%#{input}%"
    )
  end

  def title
    return unless topic

    primary? ? topic.title : format('Re: %<title>s', title: topic.title)
  end
end
