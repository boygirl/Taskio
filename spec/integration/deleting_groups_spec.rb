require "spec_helper"

feature "deleting groups" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_id: user.id, group_id: group.id) }

  scenario "users can delete groups" do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    click_link "Delete"
    page.should_not have_content("my awesome team")
  end
end
