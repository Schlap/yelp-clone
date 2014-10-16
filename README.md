Yelp Clone
==========
This week's project is an introduction to working with Rails. I recreated the core functionality of Yelp:
- users can log in and out of the service
- users can add, edit, and delete restaurants
- users can leave reviews for restaurants
- users can endorse and unendorse others' reviews
- restaurants have an average rating

Only logged-in users are able to create, edit, update, or delete restaurants. When logged in, users are also able to leave reviews, or edit/delete reviews they have already written. Users can only leave one review per restaurant and one endorsement per review. Finally, users cannot endorse their own reviews.

To do:
- set up Mailgun for confirming registration and password reset
- styling to improve UX

Technologies used:
- Ruby
- Rails
- PostgreSQL
- Active Record
- RSpec
- Capybara
- FactoryGirl
- Poltergeist
- HTML5
- jQuery
- AJAX
- Devise
- OmniAuth
- Paperclip
- AWS

How to use
----------
Clone the repository:
```shell
$ git clone git@github.com:ch2ch3/yelp-clone.git
```

Change into the directory:
```shell
$ cd yelp-clone
```

Install all dependencies:
```shell
$ bundle install
```

Create local databases for test and development:
```shell
$ psql
  =# CREATE DATABASE yelp_clone_test;
  =# CREATE DATABASE yelp_clone_development;

  =# \q
```

Run database migrations:
```shell
$ bin/rake db:migrate
```

To run the tests:
```shell
$ rspec
```

To view the app, seed the database then start the server:
```shell
$ bin/rake db:seed
$ rails server
```

Visit http://localhost:3000/restaurants in your browser. You can then login as 'ch2ch3' with the password 'password', or create a new user.