require "spec_helper"

feature "editing subtasks" do
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
    within("#subtasks #actions") do
      click_link "Edit"
    end
  end

  scenario "edit a subtask" do
    fill_in "Title", with: "gardening"
    click_button "Update Subtask"
    page.should have_content "Subtask has been updated."
    page.should have_content "gardening"
  end

  scenario "don't edit a subtask with bad data" do
    fill_in "Title", with: ""
    click_button "Update Subtask"
    page.should have_content "Subtask has not been updated."
  end
end
