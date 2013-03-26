require "spec_helper"

feature "deleting subtasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_email: user.email, group_id: group.id) }
  let!(:task) { Factory(:task, group_id: group.id) }
  let!(:subtask) { Factory(:subtask, task_id: task.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
  end

  scenario "deleting a subtask" do
    within("#subtasks #actions") do
      click_link "Delete"
    end
    page.should have_content("Your subtask has been deleted.")
  end

end
