require 'spec_helper'

# # * I must be signed in.
feature "User can submit a meetup" do
#     scenario "user sees meetups alphabetically" do
#       boston_sec = Meetup.create!({
#         name: "Boston Security Convention",
#         description: "A convention on security",
#         location: "Boston"
#         })
#       shenans_sec = Meetup.create!({
#         name: "Annual Shenanigans Meetup",
#         description: "srs bsns",
#         location: "TDB. probably"
#         })
#        no_pants = Meetup.create!({
#         name: "No Pants Dance Off",
#         description: "you can dance if you want to. you can leave your pants behind.",
#         location: "The pants store. For irony"
#         })
#       visit '/'
#       expect Meetup.all.order(:name)
#  end
# * I must supply a name.

scenario "user validates info" do
  visit '/new'
    fill_in "name", with: "PIZZA PARTY"
    fill_in "location", with: "my place"
    fill_in "description", with: "BYOP"
    click_button "Add Meetup"
  visit '/'
    expect(page).to have_content "PIZZA PARTY"
    expect(page).to have_content "my place"
    expect(page).to have_content "BYOP"
  end
  # scenario "user validates info" do
  #   visit '/new'
  #     fill_in "name", with: "PIZZA PARTY"
  #     fill_in "location", with: "my place"
  #     click_button "Add Meetup"
  #     expect(page).to have_content()
  # end

# * I must supply a location.
  pending "meetups are links" do
    visit '/'
    expect(page).to have_content "link access"
  end
end
