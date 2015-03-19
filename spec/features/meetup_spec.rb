require 'spec_helper'

# * I should see the name of the meetup.
feature "User sees meetup details" do
  scenario "user can access meetup name" do
    boston_sec = Meetup.create!({
      name: "Boston Security Convention",
      description: "A convention on security",
      location: "Boston"
      })
    visit "/meetups/#{boston_sec.id}"
    expect(page).to have_content "#{boston_sec.name}"
  end
# * I should see a description of the meetup.
  scenario "user can access meetup name" do
    boston_sec = Meetup.create!({
      name: "Boston Security Convention",
      description: "A convention on security",
      location: "Boston"
      })
    visit "/meetups/#{boston_sec.id}"
    expect(page).to have_content "#{boston_sec.description}"
  end
# * I should see where the meetup is located.
  scenario "user can access meetup name" do
    boston_sec = Meetup.create!({
      name: "Boston Security Convention",
      description: "A convention on security",
      location: "Boston"
      })
    visit "/meetups/#{boston_sec.id}"
    expect(page).to have_content "#{boston_sec.location}"
  end
end
