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

  def add_link(url, title)
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      click_button 'Add link'
    end
  end
end

feature "with a few tags" do

  scenario "when browsing the homepage" do
    visit '/'
    add_link("http://www.makersacademy.com/",
             "Makers Academy",
             ['education', 'ruby'])
    link = Link.first
    expect(link.tags.map(&:text)).to include('education')
    expect(link.tags.map(&:text)).to include('ruby')

  end

  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', :with => url
      fill_in 'title', :with => title
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add link'
    end
  end
end
