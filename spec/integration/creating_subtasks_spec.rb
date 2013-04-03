require "spec_helper"

feature "Creating Subtasks" do
  let!(:user)  { Factory(:confirmed_user) }
  let!(:group) { Factory(:group, name: "my awesome team") }
  let!(:membership) { Factory(:membership,
      email: user.email, group_id: group.id) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link group.name
    click_link "Create Task"
    fill_in "Title", with: "Clean the house"
    click_button "Create Task"
  end

  scenario "create a subtask" do
      click_link "Create Subtask"
      fill_in "Title", with: "Clean the bathroom"
      click_button "Create Subtask"
      page.should have_content("Subtask has been created.")
      page.should have_content("Clean the bathroom")
  end

  scenario "don't create a subtask without a title" do
      click_link "Create Subtask"
      click_button "Create Subtask"
      page.should have_content("Subtask has not been created.")
      page.should have_content("Title can't be blank")
  end

end
