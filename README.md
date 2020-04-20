# Movie Database application

![Mac version](https://img.shields.io/badge/MacOS-v10.13.6-lightgrey)
![Rails version](https://img.shields.io/badge/Rails-v5.2.4-orange)
![Ruby version](https://img.shields.io/badge/Ruby-v2.6.5-red)

#### Technology Stack
1. Ruby version: 2.6.5
2. Ruby on Rails Version: 5.2.4.1
3. HTML5
4. CSS3
5. jQuery
6. jQuery rateit plugin
7. Elasticsearch for free text search
8. PostgreSQL database
 

#### User Stories (Implemented)
- [x] As a guest user, I should be able to view the list of movies with average ratings.
- [x] As a guest user, I should be able to filter movies by categories or ratings.
- [x] As a guest user, I should be able to search for any movie titles (free text search).
- [x] As a guest user, I should should not be able to register without valid email.
- [x] As a guest user, I should be able to login with valid credential.
- [x] As a guest user, I should not be able to login with invalid credential.
- [ ] As a registered user, I should be able to reset my password
- [x] As a logged in user, I should be able to view the list of movies with average ratings.
- [x] As a logged in user, I should be able to view the list of movies with my own ratings.
- [x] As a logged in user, I should be able to create a new movie.
- [x] As a logged in user, I should be able to edit or delete any movie which I own.
- [x] As a logged in user, I should be able to filter or search movies.

#### Plan ahead

- [ ] Need to move UI to ReactJS from rails erb.
- [ ] Improve algorithm to calculate average rating.
- [ ] Refactor functionality to filter by categories or ratings.
- [ ] Clicking on facet filters, should update movie list without page reload.
- [ ] Write good test coverage!


#### Known issues:
1. Facet filters for categories and ratings don't populate movie count accurately. Need to figure out the perfect expected behavior.
2. Elastic search needs improvement. Currently it doesn't highlight searched keyword.

#### Demo (hosted on Heroku server):
- Visit https://movie-db-on-rails.herokuapp.com/

#### Setup on your system:
Clone this repository
```console
$ git clone https://github.com/nimeshnikum/movie_db.git
```
This application requires ElasticSearch package to be installed on your system, along with PostgreSQL database. Please make sure these are installed before you run bundler.

```console
$ bundle install
```
Create database and setup with sample data.

```console
$ rails db:setup
```
If this doesn't work, try to run commands separately

```console
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

Then run the `rails server` and go to `http://localhost:3000` to make sure everything is correct. You should see the home page with list of movies and ratings. Enjoy exploring :)

![image](https://github.com/nimeshnikum/movie_db/blob/master/public/MovieDB%20Home%20Page.png)


