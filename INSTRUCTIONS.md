# Supermarket

This is a CLI tool that can be used to process orders made at a supermarket checkout.

<!-- vim-markdown-toc GFM -->

* [Prerequisites](#prerequisites)
* [Local Setup](#local-setup)

<!-- vim-markdown-toc -->

## Prerequisites

* [Ruby v2.6+](https://www.ruby-lang.org/en/)
* [Bundler](https://bundler.io/)
* [PostgreSQL v10+](https://www.postgresql.org/)

## Local Setup

Rake commands for database operations are provided by the
[standalone_migrations gem](https://github.com/thuss/standalone-migrations).

To create the test and development databases:

    rake db:create

Run database migrations:

    rake db:migrate

Run migrations in the test environment:

    rake db:migrate RAILS_ENV=test

Seed the development database:

    rake db:seed

Clear all rows in the development database:

    rake db:seed deseed=true

Drop the test and development databases:

    rake db:drop
