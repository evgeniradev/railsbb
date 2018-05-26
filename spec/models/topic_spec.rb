require 'rails_helper'

RSpec.describe Topic do
  before do
    create :setting
    create :post
    create :post, content: 'This is post 2.'
  end

  it 'returns the primary post of a topic' do
    expect(Topic.first.primary_post.content).to eq('This is a post.')
  end
end
