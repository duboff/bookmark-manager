require 'spec_helper'

include SessionHelpers
include LinkHelpers

feature "User browses the list of links" do

  scenario "when opening the home page" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    visit '/'
    expect(page).to have_content("Makers Academy")
  end

end

feature "User adds a new link" do
  scenario "when browsing the homepage" do
    expect(Link.count).to eq 0
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    expect(Link.count).to eq 1
    link = Link.first
    expect(link.url).to eq "http://www.makersacademy.com/"
    expect(link.title).to eq "Makers Academy"
  end
end


feature "with a few tags" do

  before(:each) {
    sign_up
    add_link("http://www.makersacademy.com", "Makers Academy", ['education', 'ruby'])
    add_link("http://www.google.com", "Google", ['search'])
    add_link("http://www.bing.com", "Bing", ['search'])
    add_link("http://www.code.org", "Code.org", ['education'])
  }

  scenario "when browsing the homepage" do
    visit '/'
    link = Link.first
    expect(link.tags.map(&:text)).to include('education')
    expect(link.tags.map(&:text)).to include('ruby')
  end

  scenario 'filtered by a tag' do
    visit '/tags/search'
    expect(page).not_to have_content "Code.org"
    expect(page).to have_content "Google"
    expect(page).to have_content "Bing"
  end

end
