#GIGO: If we have garbage in we will have garbage coming out
Garbage
In
Garbage
Out


#Defensive design:
We must be defensive in ensuring that our database is a pillar of quality.

class BillingAddress < ActiveRecord
  validates :first_name,
  presence :true

  validates :last_name,
  presence: true

  validates :street_address,
  presence: true

  validates: email,
  presence: true
  format: {with: /\^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+}

  validates :state,
    presence: true,
    inclusion: {in: [
      "MA",
      "NH",
      "CA",
      "FL",
      "TX"
      ]}
end


save! will raise an exception and that will allow a loud failing alert so you know exactly
what is happening.

when you are counting on users to fuck up, and populating an active record object,
there is a high chance someone will mistype an email. This is for the stage of valid
data.

Flowcontrol to check the return value of the save and update whether they were succesful or not.

save wil issue an insert on the first save and update thereafter.

save might call update if there is an ID and call create if inpersisted

new_address.persisted?

^ Will tell us if it was added to the DB

always match schema constraints with active rcord validations
-presence and uniqueness constraints.

be as restrictive as possible.

Prefer save! create! and update! because it will halt execution
by raising an execption

save
create
update
valid?
validate
