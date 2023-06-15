# README

## Project Overview

This is a simple Rails application that represents a project management system. It includes features for commenting on projects and managing project states. Not all users have the same privileges; only staff users are allowed to change the project state.
Setup

You need to have Ruby, Rails, and a database system like PostgreSQL installed on your system. Then, clone this repository to your local machine.

After you've cloned the repository, navigate to the project directory in your terminal. Run the following commands to create, migrate, and seed the database:

```
rails db:create db:migrate db:seed
```
The seed file contains the initial data for the application, including user credentials. Be sure to check the seed file to obtain the initial authentication data.
Running Tests

The test suite is built using RSpec. To run the tests, use the following command in your terminal:

```
bundle exec rspec
```
## Questions and Decisions

### Should users be able to comment on behalf of everybody?

No, users should only be able to comment on their own behalf. I've implemented authentication using the Devise gem to ensure this.

### Should all users be able to change status?

No, not all users should be able to change the project state. Only users who are marked as staff can do this. I've implemented role management to facilitate this.

### Is the UI implementation relevant for the scope of the test?

No, for the scope of this test, I've kept the UI minimal. The main focus is on the functionality.

### How many states are there going be?

The project can be in one of the following states: draft, submitted, approved, rejected, cancelled. I've implemented this using the state_machine gem.

### Can I add gems?

Yes, using gems is a recommended way to speed up the development process and add functionality quickly. I've made use of several gems such as Devise, state_machine, and others to facilitate development.