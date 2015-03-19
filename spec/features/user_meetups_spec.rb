require 'spec_helper'

feature "User can submit a meetup" do
  let(:user) {User.create!(provider: "github", username: "hi", email: "hi.@hi.com",
  avatar_url: "example@example.com", uid: "sandwich" )}

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

# * I must supply a name.
scenario "user validates info" do
  visit "/"
  sign_in_as(user)
  visit "/meetups/new"
    fill_in "name", with: "PIZZA PARTY"
    fill_in "location", with: "my place"
    fill_in "description", with: "BYOP"
    click_button "Add Meetup"
    expect(page).to have_content("PIZZA PARTY")
    expect(page).to have_content("my place")
    expect(page).to have_content("BYOP")
  end

# * I must supply a location.
  pending "meetups are links" do
    visit '/meetups'
    expect(page).to have_content "link access"
  end

  #  * I must be signed in.
  scenario "user must be signed in" do
    visit '/'
    sign_in_as(user)
    visit '/meetups/new'
    expect(page).to have_content("Signed in as #{user.username}")
  end

  scenario "user can't access if not signed in" do
    visit '/'
    sign_in_as(user)
    click_link "Sign out"
    visit '/meetups/new'
    expect(page).to have_content("You need to sign in if you want to do that!")
  end
end
  # save_and_open_page
