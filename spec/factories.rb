FactoryBot.define do
  factory :setting do
  end

  factory :user do
    username { 'thisisme' }
    email { 'thisis@me.com' }
    password { '123456' }
    password_confirmation { '123456' }
    terms_and_conditions { true }
  end

  factory :section do
    title { 'This is a section.' }
  end

  factory :forum do
    before :create do |topic|
      topic.section = Section.first || create(:section)
    end
    title { 'This is a forum.' }
    description { 'This is the forum description.' }
  end

  factory :topic do
    before :create do |topic|
      topic.user = User.first || create(:user)
      topic.section = Section.first || create(:section)
      topic.forum = Forum.first || create(:forum)
    end
    title { 'This is a topic.' }
  end

  factory :post do
    before :create do |post|
      post.user = User.first || create(:user)
      post.section = Section.first || create(:section)
      post.forum = Forum.first || create(:forum)
      post.topic = Topic.first || create(:topic)
    end
    kind { :primary }
    content { 'This is a post.' }
  end
end
