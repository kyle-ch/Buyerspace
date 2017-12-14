# README

Final Project for my Database Design class

Buyerspace - a buyercentric marketplace

Technologies used:
mySQL for the Database
Ruby on Rails for the web app

To run:
Clone this repo.
Ensure you have ruby and ruby on rails installed on your machine
Instructions [here](https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm) for getting set up.
Ensure you have mySQL set up on your machine with our tables set up correctly.
In config/database.yml, under 'default', change username, password, and host the values that you have for your mySQL.
In your terminal, navigate to where you cloned this project to and run `rails s`
Enjoy!

CRUD operations through the front end
Create
* Buyers and Sellers create their respective accounts if their emails do not currently exist in our Database
* Buyers create postings requesting items they wish to buy
* Sellers create offers for postings they can sell to
* Buyers create ratings for sellers of completed postings
* Buyers create tags for their postings if one does not currently exist

Read
* Database is queried to determine if entered email exists
* After logging in, buyers are presented with all of the postings they have created, separated by whether or not they are completed.
* After logging in, sellers are presented with all active postings, all of their active offers, and popular tags of active postings listed in order of popularity.
* Sellers may search for postings
* Sellers may view all postings with a particular tag
* Sellers are able to see their average rating
* Sellers can see a detailed view of postings and see all of the posting's information
* Buyers can see a detailed view of a posting along with all of that posting's offers

Update
* Buyers can edit their postings by changing one or more of its fields on the edit page
* Buyers can update their posting's availability status by accepting an offer on that posting
* Buyers can update their rating of another seller by submitting another rating to that seller
* Buyers can accept or decline an offer on one of their postings

Delete
* Buyers may delete a posting
* Sellers may delete one of their active offers


Backend
Stored Functions
* average_rating(seller int) - computes the average rating of given seller by looking in the ratings table
Triggers
* offer_accpted AFTER UPDATE ON offers - Once an offer is accepted, the related posting is marked as completed
* posting_deleted Before DELETE ON postings - Before a posting is deleted, all associated offer are deleted as well.  

Error Handling
Form constraints were implemented into the front end to prohibit users from entering strings into number fields.
Input validation was implemented to ensure that email addresses were actually being entered into the email fields. 
