require "spec_helper"

feature "users can edit profiles" do
  let!(:user)  { Factory(:confirmed_user) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link user.email
  end

  scenario "users can edit their profiles" do
    click_link "Edit Profile"
    fill_in "Name", with: "Lauren"
    fill_in "Phone", with: "555-555-5555"
    click_button "Update Profile"
    page.should have_content("Your profile has been updated.")
    page.should have_content("Lauren")
  end

end
