[scrumbot][1]
=========

Friendly robot that makes you awesome at scrum. what'd you get done yesterday?

[![Build Status](https://travis-ci.org/mscoutermarsh/scrumbot.png?branch=master)](https://travis-ci.org/mscoutermarsh/scrumbot)
[![Code Climate](https://codeclimate.com/github/mscoutermarsh/scrumlogs.png)](https://codeclimate.com/github/mscoutermarsh/scrumbot)
[![Coverage Status](https://coveralls.io/repos/mscoutermarsh/scrumlogs/badge.png)](https://coveralls.io/r/mscoutermarsh/scrumbot)

----------

Hey! Purpose of this project is to make being prepared for your [morning standup][2] really easy. 

Every night, the scrumbot collects data from all the services you use everyday. Then every morning, it sends you an email with a summary of what you got done.


----------
Integrations:
=======
Currently Implemented: 

 - Github (commits and pull requests)
 - Twitter (tweets out what you got done)

ToDo:

 - Google Calendar
 - Jira
 - BaseCamp
 - WHAT ELSE?? If you have ideas, create a github issue for it.


----------
Setup:
=======
You'll need:

 - Postgres 9.3.1+ (`brew install postgres`)
 - Redis (`brew install redis`)


----------
**Steps:**

1. [Fork and clone the repo.][3]
2. Install the gems with: `bundle install`
3. `rake db:create:all`
4. `rake db:migrate`
5. `rake db:test:prepare`
6. Copy the example configuration file:
    - `cp config/application_example.yml config/application.yml`
7. Look at `config/application.yml`. This contains environment variables required for app. Has further directions on how to setup.
8. Start the web server, tests: `bundle exec guard`
9. Go to: `http://localhost:4000`

----------
Contributing:
=======
 Fork the repo, write code (and tests!), submit pull request! :heart: :sparkling_heart:
 


  [1]: https://scrumbot.io
  [2]: http://en.wikipedia.org/wiki/Stand-up_meeting
  [3]: https://help.github.com/articles/fork-a-repo