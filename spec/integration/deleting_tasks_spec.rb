require "spec_helper"

feature "deleting tasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_id: user.id, group_id: group.id) }
  let!(:task) { Factory(:task, group: group) }

  before do
    sign_in_as!(Factory(:confirmed_user))
    click_link group.name
  end

  scenario "deleting a task" do
    within("#tasks") do
      click_link "Delete"
    end
    page.should have_content("Your task has been deleted.")
  end

end
