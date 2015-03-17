require 'spec_helper'

# * Meetups should be listed alphabetically.
feature "User view meetup order" do
  scenario "user sees meetups alphabetically" do
    boston_sec = Meetup.create!({
      name: "Boston Security Convention",
      description: "A convention on security",
      location: "Boston"
      })
    shenans_sec = Meetup.create!({
      name: "Annual Shenanigans Meetup",
      description: "srs bsns",
      location: "TDB. probably"
      })
     no_pants = Meetup.create!({
      name: "No Pants Dance Off",
      description: "you can dance if you want to. you can leave your pants behind.",
      location: "The pants store. For irony"
      })
    visit '/'
    expect Meetup.all.order(:name)
  end
end

# * Each meetup listed should link me to the show page for that meetup.
feature "User has meetup links" do
  scenario "meetups are links" do
    boston_sec = Meetup.create!({
      name: "Boston Security Convention",
      description: "A convention on security",
      location: "Boston"
      })
    shenans_sec = Meetup.create!({
      name: "Annual Shenanigans Meetup",
      description: "srs bsns",
      location: "TDB. probably"
      })
     no_pants = Meetup.create!({
      name: "No Pants Dance Off",
      description: "you can dance if you want to. you can leave your pants behind.",
      location: "The pants store. For irony"
      })
    visit '/'
    expect(page).to have_link "#{boston_sec.name}"
    expect(page).to have_link "#{shenans_sec.name}"
    expect(page).to have_link "#{no_pants.name}"
  end
end
