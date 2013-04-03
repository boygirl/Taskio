require "spec_helper"

feature "deleting tasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      email: user.email, group_id: group.id) }
  let!(:task) { Factory(:task, group_id: group.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
  end

  scenario "deleting a task" do
    within("#tasks #actions") do
      click_link "Delete"
    end
    page.should have_content("Your task has been deleted.")
    page.should_not have_content(task.title)
  end

end
