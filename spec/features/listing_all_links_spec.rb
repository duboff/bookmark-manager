require 'spec_helper'

feature "User browses the list of links" do
  before(:each) {
    Link.create(:title => "Makers Academy",
                :url => "http://www.makersacademy.com")
  }

  scenario "when opening the hom page" do
    visit '/'
    expect(page).to have_content("Makers Academy")
  end

end

feature "User adds a new link" do

  scenario "when browsing the homepage" do
    expect(Link.count).to eq 0
    visit '/'
    add_link("http://www.makersacademy.com/", "Makers Academy")
    expect(Link.count).to eq 1
    link = Link.first
    expect(link.url).to eq "http://www.makersacademy.com/"
    expect(link.title).to eq "Makers Academy"
  end
end

def add_link(url, title, tags = [])
  within('#new-link') do
    fill_in 'url', :with => url
    fill_in 'title', :with => title
    fill_in 'tags', :with => tags.join(' ')
    click_button 'Add link'
  end
end


feature "with a few tags" do

  before(:each) {
    Link.create(:title => "Makers Academy",
                :url => "http://www.makersacademy.com",
                :tags => [Tag.first_or_create(:text => 'education'), :text => 'ruby'])
    Link.create(:url => "http://www.google.com",
                :title => "Google",
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.bing.com",
                :title => "Bing",
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.code.org",
                :title => "Code.org",
                :tags => [Tag.first_or_create(:text => 'education')])
  }


  scenario "when browsing the homepage" do
    visit '/'
    link = Link.first
    expect(link.tags.map(&:text)).to include('education')
    expect(link.tags.map(&:text)).to include('ruby')
  end

  scenario 'filtered by a tag' do
    visit '/tags/search'
    expect(page).not_to have_content "Makers Academy"
    expect(page).not_to have_content "Code.org"
    expect(page).to have_content "Google"
    expect(page).to have_content "Bing"
  end




end
