Yelp Clone
==========
This week's project is an introduction to working with Rails. The aim is to recreate the core functionality of Yelp such that:
- users can log in and out of the service
- users can add, edit, and delete restaurants
- users can leave reviews for restaurants

Only logged-in users should be able to create restaurants and leave reviews, users should not be able to edit or delete restaurants they did not add, and users can only leave one review per restaurant.

Current stage of project:
- restaurants can be created, edited, deleted
- users can write reviews
- users can endorse reviews written by other users
- restaurants have an average rating calculated from all submitted reviews

The next steps are setting up user accounts, restricting some features to logged-in users, and eventually an improved UX.

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

Start the server:
```shell
$ rails server
```

Visit http://localhost:3000/restaurants in your browser.