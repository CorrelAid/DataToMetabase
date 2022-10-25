# Data to Metabase: Automated Curation with the Metabase API

## What is this project about?

One of two Metabase-centric projects (see [Metabase-to-Google](https://github.com/CorrelAid/metabase-to-google)). This project will explore automated approaches to (pre-)curating a Metabase instance with Dashboards and queries through the [Metabase API](https://www.metabase.com/docs/latest/api-documentation).

Two appropaches are possible

- recommended: send GET/POST requests to the Metabase API to run queries remotely
- (not recommended / warning): write directly into the Metabase DB where Metabase stores it's meta data

For both cases, we want to track created cards and dashboards in a file or spreadsheed (e.g. Google Sheets).

# Setup

## `renv`: Installing Packages

`renv` brings project-local R dependency management to our project.
`renv` uses a lockfile (`renv.lock`) to capture the state of your
library at some point in time. Based on `renv.lock`, RStudio should
automatically recognize that it’s being needed, thereby downloading and
installing the appropriate version of `renv` into the project library.
After this has completed, you can then use `renv::restore()` to restore
the project library locally on your machine. When new packages are used,
`install.packages()` does not install packages globally, it does in an
environment only used for our project. You can find this library in
`renv/library` (but it should not be necessary to look at it). If `renv`
fails, you will be presented something in the like of when you first
start R after cloning the repo:

    renv::restore()
    This project has not yet been activated. Activating this project will ensure the project library is used during restore. Please see ?renv::activate for more details. Would you like to activate this project before restore? [Y/n]:

Follow along with `Y` and `renv::restore()` will do its work downloading
and installing all dependencies. `renv` uses a local `.Rprofile` and
`renv/activate.R` script to handle our project dependencies.

### Adding a new package

If you need to add a new package, you can install it as usual
(`install.packages` etc.). Then, to add your package to the `renv.lock`:

    renv::snapshot()

and commit and push your `renv.lock`.

Other team members can then run `renv::restore()` to install the added
package(s) on their laptop.

## Access data

To access the data for this challenge, you first need to get
secrets/passwords. Reach out to the project host or team lead.

To connect to the Coolify Postgres database, you need to store your
credentials in the `.Renviron` file. We'll use a **project**-specific `.Renviron` file:

- with `usethis::edit_r_environ(scope = "project")`
- or copy template with `cp .Renviron.example .Renviron` and edit there

Copy the content from the decrypted secret link. It should look
something like this:

    # logins for supabase
    COOLIFY_NAME='postgres'
    COOLIFY_HOST='your-supabase-url'
    COOLIFY_PORT='5432'
    COOLIFY_USER='postgres'
    COOLIFY_PASSWORD='your-supabase-pw'
    COOLIFY_DB='defaultdb'

Restart your R session (Session -> Restart R Session or
`.rs.restartR()`)

Read and run `R/00-connect-to-coolify.R` or explore in `00-db-connection-test.Rmd`

### Description of relevant tables

> TODO

For now we'll be working with the `penguins` data set from the [`palmerpenguins`](https://allisonhorst.github.io/palmerpenguins/) R package.

# Developer information

## Definition of Done

Default Definition of Done can be found
[here](https://github.com/CorrelAid/definition-of-done). Adapt if
needed.

## Code styling

# How to operate this project?

\[the following can also be moved to the wiki if you decide to have
one\]

explain how the output(s) of this project can be handled/operated, for
example:

- how to knit the report(s)
- where to create/find the data visualizations
- how to update data
- what would need to be updated if someone wanted to re-run your
  analysis with different data

# Limitations

be honest about the limitations of your project, e.g.:

- methodological: maybe another model would be more suitable?
- reproducibility: what are limits of reproducibility? is there
  something hard-coded/specific to the data that you used?
- best practices: maybe some code is particularly messy and people
  working on it in the future should know about it in advance?
