require "application_system_test_case"

class GoalsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:one)
  end

  test "visiting the index" do
    skip
    visit goals_url
    assert_selector "h1", text: "Goals"
  end

  test "should create goal" do
    skip
    visit goals_url
    click_on "New goal"

    fill_in "Description", with: @goal.description
    fill_in "Status", with: @goal.status
    fill_in "Title", with: @goal.title
    click_on "Create Goal"

    assert_text "Goal was successfully created"
    click_on "Back"
  end

  test "should update Goal" do
    skip
    visit goal_url(@goal)
    click_on "Edit this goal", match: :first

    fill_in "Description", with: @goal.description
    fill_in "Status", with: @goal.status
    fill_in "Title", with: @goal.title
    click_on "Update Goal"

    assert_text "Goal was successfully updated"
    click_on "Back"
  end

  test "should destroy Goal" do
    skip
    visit goal_url(@goal)
    click_on "Destroy this goal", match: :first

    assert_text "Goal was successfully destroyed"
  end
end
