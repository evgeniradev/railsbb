require 'rails_helper'

RSpec.describe Post do
  before do
    create :setting
  end

  let :primary_post do
    create :post
  end

  let :non_primary_post do
    create :post, content: 'This is post 2.', kind: :standard
  end

  it 'returns the title of a primary post' do
    expect(primary_post.title).to eq('This is a topic.')
  end

  it 'returns the title of a non-primary post' do
    expect(non_primary_post.title).to eq('Re: This is a topic.')
  end

  it 'finds a post based on input' do
    primary_post
    non_primary_post
    expect(Post.search('is a post').size).to eq(1)
  end
end
