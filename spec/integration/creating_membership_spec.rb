require "spec_helper"

feature "creating memberships" do
  let!(:user1)  { Factory(:confirmed_user) }
  let!(:user2)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_email: user1.email, group_id: group.id) }

  before do
    sign_in_as!(user1)
    visit '/'
    click_link group.name
  end

  scenario "users can add users to a group" do
    click_link "Invite Collaborators"
    fill_in "User email", with: user2.email
    click_button "Create Membership"
    page.should have_content("Your collaborator has been added.")
  end

  scenario "don't create a memebership for an invalid email address" do
    click_link "Invite Collaborators"
    fill_in "User email", with: "asdf"
    click_button "Create Membership"
    page.should have_content("Your collaborator has not been added.")
    page.should have_content("User email is invalid")
  end
end
