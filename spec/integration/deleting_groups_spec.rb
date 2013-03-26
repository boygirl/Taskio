require "spec_helper"

feature "deleting groups" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_email: user.email, group_id: group.id) }

  scenario "users can leave groups" do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    click_link "Leave Group"
    page.should_not have_content("my awesome team")
  end
end
