require 'rails_helper'

RSpec.describe SectionsController do
  before do
    create :setting
    create :post
  end

  it 'requires users to sign in order to enter forums' do
    visit '/'
    click_link('This is a topic.')
    expect(page).to have_button 'Log in'
  end
end
