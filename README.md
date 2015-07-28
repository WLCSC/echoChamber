# Echo Chamber

A program for playing sounds in school.

## Setup

```bash
gem install bundler # if Bundler is not already installed
bundle install
cp config/ldap.yml.sample config/ldap.yml
rake db:migrate
```

## Running

```bash
rails s
```
