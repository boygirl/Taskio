require 'spec_helper'

feature "Creating Tasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      user_email: user.email, group_id: group.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    click_link "Create Task"
  end

  scenario "create a task" do
    fill_in "Title", with: "Clean the house"
    click_button "Create Task"
    page.should have_content("Your task has been created.")
  end

  scenario "don't create an empty task" do
  click_button "Create Task"
  page.should have_content("Your task has not been created.")
  page.should have_content("Title can't be blank")
  end
end
