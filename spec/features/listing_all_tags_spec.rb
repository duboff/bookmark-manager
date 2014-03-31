require 'spec_helper'

feature "Shows list of avaialble tags" do
  before(:each) {
    Link.create(:title => "Makers Academy",
                :url => "http://www.makersacademy.com",
                :tags => ['education', 'ruby'])
  }

  scenario "when opening the hom page" do
    visit '/'
    expect(page).to have_content("education")
  end

end
