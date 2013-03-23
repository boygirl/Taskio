require "spec_helper"

feature "Viewing your profile" do
  let!(:user)  { Factory(:confirmed_user) }

  scenario "users can view their profiles" do
    sign_in_as!(user)
    visit '/'
    click_link user.email
    page.should have_content(user.email)
  end
end
