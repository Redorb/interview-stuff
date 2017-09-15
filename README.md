# Rover Coding Project

![Alt text](/readme_imgs/1.png)
![Alt text](/readme_imgs/2.png)
![Alt text](/readme_imgs/3.png)
![Alt text](/readme_imgs/4.png)

### Setup
Assumes Mac Setup with Homebrew, if not use package manager equivalent
1. Clone this repo.
2. Install ruby 2.4.1 (`brew install ruby`)
3. Install the bundler gem (`gem install bundler`)
4. Install nodejs and npm (`brew install nodejs`)
5. Install yarn (`npm install yarn`)
6. In the repo directoy run `bundle install`
7. Go into the client directoy and run `yarn install`
8. Go back to the root repository and run `rails db:create && rails db:migrate`
9. Seed the database with the csv by running `rake data_migration:bulk_csv_import`
10. To start the app run `foreman start -f Procfile.dev`

### Backend Design Decisions
The backend for this webapp is a standard rails api. The one things to note
is that there are a few unused routes that I was planning on using in the future
for extra features, you can run rake routes and see all the endpoints available. As per my usual way of doing things I scoped all api requests to the /api/ url endpoint to make things easier on the frontend.

For the actual design I have 4 tables (Pets, Stays, Users, and a PetStays join table)
which could be condensed without the pets table but if you wanted to add more profile
info on the pet later you'd need to split it out anyhow. I debated on splitting up
the user class into a sitter and pet owner role, but like on the rover site any user
can be either so I'm using a role management solution. (Relevant files are in models/concerns/roles.rb)
There is authentication built in but it's not hooked up to the
frontend since it wasn't a requirement but I wanted to test it. 

The main backend design decision though was probably when to update the user rankings which I decided to do on a new stay insertion. The actual ranking values themselves are cached in the database so they don't need to be recalculated later. Finally, I normally use postgresql for the database backend but wanted to keep things easy so left it with sqlite.

Important Backend Folders to Checkout:
- /app/controllers
- /app/models
- /spec/ (All the tests)
- /lib/tasks (Migration and startup stuff)
- /db/schema.rb

### Frontend Design Decisions
The frontend is using react+router, I thought about adding redux but figured it'd be overkill at the present time. All the components live in the client/src/components directory which are separated into relevant component folders to easily track down files. One major extra feature in the app is when navigating from /sitters/ by clicking on a user row takes you to their profile which has a bunch of statistics and all their reviews. There's also a form to submit a booking but I don't have that hooked up right now without the authentication.

On the sitter list page since the only filter specified in the requirements is by ranking I kept it pretty simple. The use selects the minimum rating from the stars at the top and the list is automatically resorted (No separate request though I did have paging at one point) There isn't too much else going on with the frontend other than the request logic is in libs/agent.js which makes all the mess a lot easier to grok.

Important Frontend Folders to Checkout:
- /client/components
- /client/libs
- /client/styles
