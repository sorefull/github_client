# README

This is a client working with Github's API. Although there is like ability for users and repositories. Feel free to use it and have a nice day.

## Installation

Nice to see that you are interested to try my application.

First need to clone it:

`
git clone https://github.com/sorefull/github_client.git && cd github_client
`

Secondly you need to bundle it and migrate database:

`
bundle install && rails db:migrate
`

Sadly GitHub API allows only 50 requests per hour for a non-authorized user. To increase the limit to 5000 requests/hour, I am using Basic Authorization headers. To use my app with higher limit you need to [create oath application](https://github.com/settings/applications/new) and set Client ID with Client Secret in `config/application.yml` as it is shown in `application.example.yml`.

All is done and you can finally serve application:

`
rails server
`
