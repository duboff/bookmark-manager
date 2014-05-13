require 'spec_helper'

include SessionHelpers

feature "User signs up" do
  scenario "when being logged out" do
    lambda { sign_up }.should change(User, :count).by 1
    expect(page).to have_content "Welcome, alice@example.com"
    expect(User.first.email).to eq 'alice@example.com'
  end

  scenario 'with a password that does not match' do
    lambda { sign_up('a@a.com', 'pass', 'wrong')}.should change(User, :count).by(0)
    expect(current_path).to eq '/users'
    expect(page).to have_content "Sorry, your passwords don't match"
  end

  scenario 'with an email that is already registered' do
    lambda { sign_up }.should change(User, :count).by 1
    lambda { sign_up }.should change(User, :count).by 0
    expect(page).to have_content 'This email is already taken'
  end
end

feature 'User signs in' do
  before(:each) do
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content "Welcome, test@test.com"
    sign_in('test@test.com', 'test')
    expect(page).to have_content "Welcome, test@test.com"
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content "Welcome, test@test.com"
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content "Welcome, test@test.com"
  end
end

feature 'User signs out' do
  before(:each) do
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'while being sidned in' do
    sign_in('test@test.com', 'test')
    click_button 'Sign out'
    expect(page).to have_content 'Good bye!'
    expect(page).not_to have_content "Welcome, test@test.com"
  end
end

feature 'User forgets his password' do
  before(:each) do
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'and exists in the database' do
    visit '/users/passwordreset'
    expect(page).to have_content 'Please enter your email'
    fill_in :email, :with => 'test@test.com'
    click_button 'Send'
    expect(current_path).to eq '/users/passwordreset/success'
    expect(page).to have_content 'Password recovery email sent'
    user = User.first(:email => 'test@test.com')
    expect(current_path).to eq '/users/passwordreset/success'
  end

  scenario 'and does not exist in the database' do
    visit '/users/passwordreset'
    expect(page).to have_content 'Please enter your email'
    fill_in :email, :with => 'wrong@test.com'
    click_button 'Send'
    expect(current_path).to eq '/users/passwordreset/fail'
    expect(page).to have_content "Can't find this email in our database."
    click_button 'Try again'
    expect(current_path).to eq '/users/passwordreset'
  end
end
