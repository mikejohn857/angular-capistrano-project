# Capistrano

wip - aim here is to get 'something' up and running

TODO:

  - [x] harness rake for dsl
  - [x] create a working capify equivalent
    - [x] create Capfile
    - [x] create lib/tasks/deploy
    - [x] create config/deploy/
    - [x] write config/deploy.rb with example configuration

  - [x] basic configuration object
  - [x] basic 'capistrano/deploy' noop example
  - [x] don't care too much about testing at this point (rspec included for my reference)

  - [x] before/after task hooks
  - [x] handle multi stage
  - [ ] pass any necessary configuration from deploy.rb to SSHKit
  - [ ] is Capfile still legit? (although capfile/capfile.rb are already alternatives by default)

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano' github: 'capistrano/capistrano', branch: :wip

And then execute:

    $ bundle --binstubs

Capify:

    $ cap install

This creates the following files:

- `Capfile`
- `lib/deploy/tasks`
- `config/deploy/staging.rb`
- `config/deploy/production.rb`

To create different stages:

    $ cap install STAGES=local,sandbox,qa,production

## Usage

    $ cap -vT

    $ cap staging deploy
    $ cap production deploy

## Tasks

## Before / After

Where calling on the same task name, executed in order of inclusion


    # call an existing task
    before :starting, :ensure_user

    after :finishing, :notify


    # or define in block
    before :starting, :ensure_user do
      #
    end

    after :finishing, :notify do
      #
    end

## Configuration


## SSHKit



