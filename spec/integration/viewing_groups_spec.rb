require "spec_helper"

feature "viewing groups" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:not_your_group) { Factory(:group, name: "the other team") }
  let!(:membership) { Factory(:membership,
      email: user.email, group_id: group.id) }

  scenario "users should only see their own groups" do
    sign_in_as!(user)
    visit '/'
    page.should have_content("my awesome team")
    page.should_not have_content("the other team")
  end
end
