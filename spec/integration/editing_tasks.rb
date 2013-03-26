require "spec_helper"

feature "Editing Tasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_id: user.id, group_id: group.id) }
  let!(:task) { Factory(:task, group_id: group.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    within("#tasks #actions") do
      click_link "Edit"
    end
  end

  scenario "edit a task" do
    fill_in "Title", with: "Bathroom Cleaning"
    click_button "Update Task"
    page.should have_content("Your task has been updated.")
    page.should have_content("Bathroom Cleaning")
  end

  scenario "edit a task with invalid information" do
    fill_in "Title", with: ""
    click_button "Update Task"
    page.should have_content("Your task has not been updated.")
  end
end
