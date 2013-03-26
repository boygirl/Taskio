require "spec_helper"

feature "viewing groups" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_email: user.email, group_id: group.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    click_link "Edit"
  end

  scenario "users can edit their groups" do
    fill_in "Name", with: "my super awesome team"
    click_button "Update Group"
    page.should have_content("Your group has been updated.")
  end

  scenario "users can't edit groups with invalid data" do
    fill_in "Name", with: ""
    click_button "Update Group"
    page.should have_content("Your group has not been updated.")
    page.should have_content("Name can't be blank")
  end

end
