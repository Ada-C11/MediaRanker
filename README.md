# Media Ranker

## Introduction

In this project, you will build a webapp where users can vote for their favorite pieces of media.

In contrast to previous projects, instead of implementing a pre-defined spec you will be imitating an existing site: http://media-ranker-2-0.herokuapp.com. Your job is to match the functionality and styling of this site as closely as possible.

This is an individual, [stage 2](https://github.com/Ada-Developers-Academy/pedagogy/blob/master/rule-of-three.md) project, due before class Monday April 29.

## Learning Goals

The purpose of this assignment is to reinforce the following concepts:

- Previous Rails learning, including MVC, RESTful routing, and the request cycle
- Testing Rails applications
- Building complex model logic
- Using `session` and `flash` to track data between requests
- DRYing up Rails code

## Before You Begin

### Provided Files

- `db/media_seeds.csv`: Some starter media to work with
- `app/assets/images/owl.jpg`: The owl picture from the site

### Regarding the Word "Media"

The Rails inflector considers "media" to be the plural of "medium", which is not really what we mean here. You may want to choose a different word to represent "a book, movie or album" internally. The instructor-proved example site uses the word "work".

## Project Requirements

### Core Requirements

Regardless of how you choose to implement this project or how much of it gets done, you should exhibit

- Squeaky-clean **git hygiene**, including
  - A fresh branch for each new feature
  - Regular commits
  - Descriptive commit messages
- Fanatical devotion to **test-driven development**
  - Pseudocode first, then write the tests, then write code to make them pass
- Steadfast adherence to **agile development practices**
  - User stories should be listed and prioritized using a Trello board
  - The finished application should be deployed to Heroku (deploy early, deploy often)
- Unrelenting use of **semantic HTML**

### Baseline

We will begin with some in-class work, exploring the site and pondering implementation details. Before you start writing _any_ code, you should:

- Explore the existing Media Ranker site to become familiar with the necessary functionality
- Create a Trello board to manage user stories
- Create an ERD for the models

Then, once you have a solid plan for how to structure your project:

- Fork and clone the repo
- Use `rails new .` to generate a new Rails project in the cloned directory
  - Verify that the changes we've made to Rails' defaults (postgres as the DB, spec-style testing) have been applied
- `git add .` and `git commit -m "Initial Rails setup"`

### Wave 1

In this wave, you should build some functionality, and then build the tests for that functionality. We recommend doing the read and create operations first, then writing tests, then completing the update and delete operations.

Mimic the site's basic functionality around Media, without worrying (yet) about Users or Votes:
- Build a main page, with a list of the media for each category, as well as a spotlight section for the top media overall.
    - Since we don't have votes yet, for both the spotlight and top-10 sections you should select works at random (i.e. using `.sample`)
- Build an index page with a list of all works for each category
- Allow users to add new works
- Build a details page for each piece of media
- Allow users to edit and delete works

#### Organization

Think about what functionality should live in the model. Given that the way you select the spotlight and top-10 are going to change in a future wave, how can you isolate this business logic to make it easy to change?

#### Testing

**Before** moving on to wave 2, your project should contain the following tests

**Model Testing**
- All validations and should be tested
- All custom methods should be tested
    - For top-10 or spotlight, what if there are less than 10 works? What if there are no works?

**Controller Testing**
- Tests for standard CRUD operations on works
- Does the main page load if there are no works?

### Wave 2

Mimic the site's functionality around Users and Voting:
- Allow users to "log in" to the site, and use the `session` to keep track of which user is currently logged in for a given browser
- Allow users to vote for media, and sort media by vote count whenever a list of media is displayed
- Don't allow a user to vote for the same media more than once
- Change the media spotlight and top-10 to respect vote count

#### Testing

**Before** moving on to wave 3, your project should contain the following tests

**Model Testing**
- All validations for new models should be tested
- All relations between models should be tested
- Your tests for custom model methods should be updated to reflect the presence of votes
    - How do top-10 and spotlight handle works with no votes? Ties in the number of votes?

**Controller Testing**
- Tests for all individual actions
- Authentication tests combining multiple actions
    - A guest user _cannot_ vote if they have not logged in
    - A logged-in user _can_ vote for a work they haven't already voted for
    - A logged-in user _cannot_ vote for a work they have previously voted for

Focus on testing voting logic since this is the most complex part of Wave 2.

#### A note on logging in

Passwords and security are tricky! We'll talk about that sort of thing a little in the coming weeks, but for now you don't need to provide any sort of security. The user gives you a username, and your site should just trust them.

### Wave 3
- Add a list of voting users to the details page for each media
- Add a page for each user, as well as a page showing a summary of all users

### Optional Enhancement Ideas

Use Bootstrap and CSS to style the site to match the example. The layout as well as the look and feel should match as close as possible.

Once your test coverage is comprehensive, your HTML is semantic, your user stories have all been moved to the `Done` column and your application has been deployed to Heroku, you may consider the following enhancements.

1. DRY up your code as much as you can! Techniques worth investigating:
    - Helper methods
    - Controller filters
1. Build category-specific pages for `index` and `new` (e.g. `/books` or `/movies/new`). These should be as DRY as possible. You might be interested in investigating _polymorphic routes_.
1. Add a [recommendation system](https://www.toptal.com/algorithms/predicting-likes-inside-a-simple-recommendation-engine) that suggests media to a user based on what they have previously voted for.

## What we're looking for
You can find what instructors will be looking for in the [feedback](feedback.md) markdown document.
