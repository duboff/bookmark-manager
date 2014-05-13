require 'spec_helper'

include SessionHelpers
include LinkHelpers

feature "Shows list of avaialble tags" do

  scenario "when opening the home page" do
    sign_up
    add_link("http://www.makersacademy.com", "Makers Academy", ['education', 'ruby'])
    visit '/'
    expect(page).to have_content("education")
  end

end
