require "rails_helper"

feature "User views Task", js: true do

  scenario "User views a Task that have assigned to themselves" do
    as_a_user_who_is_on_the_tasks_page
    when_i_view_a_user_task_assigned_to_myself
    then_i_should_see_the_user_task_details
  end

  scenario "User views a Procedure Task they assigned to themselves" do
    as_a_user_who_has_been_assigned_a_procedure_task
    when_i_view_the_procedure_task_assigned_to_myself
    then_i_should_see_the_procedure_task_details
  end

  def as_a_user_who_is_on_the_tasks_page
    visit tasks_path
  end

  def when_i_view_a_user_task_assigned_to_myself
    assignee = User.first

    click_link "Create New Task"
    select assignee.full_name, from: 'task_assignee_id'
    page.execute_script %Q{ $('#task_due_date').trigger("focus") }
    page.execute_script %Q{ $("td.day:contains('15')").trigger("click") }
    fill_in :task_body, with: "Test body"
    click_button 'Save'
    find("table.tasks tbody tr:first-child").click
  end

  def as_a_user_who_has_been_assigned_a_procedure_task
    create(:protocol_imported_from_sparc)
    user        = User.first
    appointment = Appointment.first
    visit       = Visit.first
    procedure   = create(:procedure, appointment: appointment, visit: visit)

    procedure.tasks.push build(:task, user: user, assignee: user)
  end

  def when_i_view_the_procedure_task_assigned_to_myself
    as_a_user_who_is_on_the_tasks_page
    find("table.tasks tbody tr:first-child").click
  end

  def then_i_should_see_the_user_task_details
    expect(page).to have_css(".modal dt", text: "Created by")
    expect(page).to have_css(".modal dt", text: "Assigned to")
    expect(page).to have_css(".modal dt", text: "Type")
    expect(page).to have_css(".modal dt", text: "Task")
    expect(page).to have_css(".modal dt", text: "Due date")
    expect(page).to have_css(".modal dt", text: "Completed")
  end

  def then_i_should_see_the_procedure_task_details
    then_i_should_see_the_user_task_details
    expect(page).to have_css(".modal dt", text: "Participant name")
    expect(page).to have_css(".modal dt", text: "Protocol")
    expect(page).to have_css(".modal dt", text: "Visit")
    expect(page).to have_css(".modal dt", text: "Arm")
  end
end
