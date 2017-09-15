# Interview Coding Project

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
