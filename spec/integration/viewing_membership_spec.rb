require "spec_helper"

feature "viewing memberships" do
  let!(:user1)  { Factory(:confirmed_user) }
  let!(:user2)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      email: user1.email, group_id: group.id) }
  let!(:membership2) {  Factory(:membership,
      email: user2.email, group_id: group.id) }

  before do
    sign_in_as!(user1)
    visit '/'
    click_link group.name
  end

  scenario "users can see all members of a group" do
    page.should have_content(user2.email)
  end
end
