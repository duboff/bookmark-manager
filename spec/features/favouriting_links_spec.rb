require 'spec_helper'

include SessionHelpers
include LinkHelpers

feature "Adding a link to favourites" do

  scenario "can add your own link when logged in" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    link = Link.first
    expect(link.users.count).to eq 0
    click_button 'add_to_fav'
    expect(link.users.count).to eq 1
  end

  scenario "when it's another user's link when logged in" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    link = Link.first
    click_button 'Sign out'
    sign_up('bob@example.com', 'bob', "oranges!", "oranges!")
    click_button 'add_to_fav'
    expect(link.users.count).to eq 1
  end

  scenario "counter increments by one" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    link = Link.first
    click_button 'add_to_fav'
    expect(page).to have_css('.favs', text: '1')
  end

  scenario "can't add to favourites when signed out" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    click_button 'Sign out'
    expect(page).not_to have_css '#add_to_fav'
  end

  scenario "can't add to favourites more than once" do
    sign_up
    add_link("http://www.makersacademy.com/", "Makers Academy")
    click_button 'add_to_fav'
    expect(page).not_to have_css '#add_to_fav'
  end

end
