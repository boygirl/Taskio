require "spec_helper"

feature "viewing subtasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_id: user.id, group_id: group.id) }
  let!(:task) { Factory(:task, group_id: group.id) }
  let!(:subtask) { Factory(:subtask, task_id: task.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
  end

  scenario "view a subtask from a task" do
    page.should have_content(subtask.title)
  end
end
