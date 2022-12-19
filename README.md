# Data to Metabase: Automated Curation with the Metabase API

## What is this project about?

One of two Metabase-centric projects (see [Metabase-to-Google](https://github.com/CorrelAid/metabase-to-google)).
This project will explore automated approaches to (pre-)curating a Metabase instance with Dashboards
and queries through the [Metabase API](https://www.metabase.com/docs/latest/api-documentation).

Two approaches are possible

-   recommended: send GET/POST requests to the Metabase API to run queries remotely
-   (not recommended / warning): write directly into the Metabase DB where Metabase stores it's meta data

For both cases, we want to track created cards and dashboards in a file or spreadsheed (e.g. Google Sheets).

## Setup

### R installation

Installation files for R for Windows, Linux and MacOS can be found on
[CRAN](https://cran.r-project.org/). This includes both the current version
as well as older versions.

Linux binaries can also be found directly from [Posit](https://docs.rstudio.com/resources/install-r/) for a larger
variety of linux distributions.

### RStudio installation

RStudio is on of the most commonly used IDEs for R and is highly recommended.
RStudio Desktop can be downloaded as a GUI application from [Posit](https://posit.co/downloads/).

Alternatively RStudio Server can be downloaded [here](https://posit.co/download/rstudio-server/).
When starting such a server locally it provides essentially the same UI as RStudio Desktop as a
WEBUI in a browser. Currently not all browsers seem to be supported.

- Firefox ✔
- Edge ❌

It is recommended that WSL users use RStudio Server because RStudio Desktop does not integrate
well with WSL. 

#### RStudio Server hints

Unfortunately there does not seem to be a dedicated RStudio Server documentation
for the free version. It is possibly to use the [documentation for
the pro version](https://docs.rstudio.com/ide/server-pro/), but not everything
might apply. We therefore have a few hints to help to get started.

1. `sudo rstudio-server verify-installation` helps to check whether everything
  is installed properly and no dynamic dependencies (C header files) are missing. 

2. `sudo rstudio-server start` starts the server

3. `sudo rstudio-server stop` stops the server

4. The default address for accessing the server is http://localhost:8787

5. Login credentials are the linux users credentials

### `renv`: Package / Dependency Management

-   `renv` brings project-local R dependency management to our project.
-   `renv` uses a lockfile (`renv.lock`) to capture the state of your library at some point in time.
-   Based on `renv.lock`, RStudio should automatically recognize that it's being needed, thereby downloading and installing the appropriate version of `renv` into the project library.

> VSCode users might need to manually run `renv::activate()`.\
> In this Project, `languageserver` for VSCode is ignored by `renv`.

After this has completed, you can then use `renv::restore()` to restore the project library locally on your machine.

When new packages are used, `install.packages()` does not install packages globally, it does so in an environment only used for our project. You can find this library in `renv/library` (but it should not be necessary to look at it).

If `renv` fails, you will be presented something in the like of when you first start R after cloning the repo:

    renv::restore()
    This project has not yet been activated. Activating this project will ensure the project library is used during restore. Please see ?renv::activate for more details. Would you like to activate this project before restore? [Y/n]:

Follow along with `Y` and `renv::restore()` will do its work downloading and installing all dependencies.

`renv` uses a local `.Rprofile` and `renv/activate.R` script to handle our project dependencies.

#### Adding a new package

You can always check the status of your local project state with `renv::status()`.

If you need to add a new package, you can install it as usual (`install.packages` etc.).

Then, to **add** your package to the `renv.lock`:

    renv::snapshot()

This will add the package as a dependency to `renv.lock`. Now commit and push your `renv.lock`.

Other team members can then run `renv::restore()` to install the added package(s) on their laptop.

> You might want to **notify** team members about package updates (e.g. in the commit message or via Slack)

### pre-commit setup

The project uses pre-commit to run certain quality assurance checks automatically on each commit. We use the
cran [precommit package](https://lorenzwalthert.github.io/precommit/index.html). Most of the time it should
be enough to ensure that the python based `pre-commit` cli tool is installed. The most convenient way is
to run the following in a command line:

    pip3 install pre-commit --user

For alternative installation instructions please see the precommit webpage. In order to activate the pre-commit
hooks in a local repository run the following in the project's R console:

    precommit::use_precommit()
    
To check whether the setup worked correctly you can run the following command in the command line. Note
that you might have to open a new session if it is the same one that you used to install `pre-commit` or the
executable might not be found:

    pre-commit run --all-files


### Data Access

To access the data for this challenge, you first need to get secrets/passwords. Reach out to the project host or team lead.

To connect to the Coolify Postgres database, you need to store your credentials in the `.Renviron` file. We'll use a **project**-specific `.Renviron` file:

-   with `usethis::edit_r_environ(scope = "project")`
-   or copy the template with `cp .Renviron.example .Renviron` and edit it

Copy the content from the decrypted secret link. It should look something like this:

    # logins for supabase
    COOLIFY_NAME='postgres'
    COOLIFY_HOST='your-supabase-url'
    COOLIFY_PORT='5432'
    COOLIFY_USER='postgres'
    COOLIFY_PASSWORD='your-supabase-pw'
    COOLIFY_DB='defaultdb'

Restart your R session (Session -\> Restart R Session or `.rs.restartR()`)

Read and run `R/00-connect-to-coolify.R` or explore in `00-db-connection-test.Rmd`

#### Description of relevant tables

> TODO

For now we'll be working with the `penguins` data set from the [`palmerpenguins`](https://allisonhorst.github.io/palmerpenguins/) R package.

## Developer Information

### Definition of Done (DoD)

CorrelAid's default Definition of Done can be found [here](https://github.com/CorrelAid/definition-of-done). Adapt as needed.

### Code styling

#### Linting

This project uses the [`lintr`](https://github.com/r-lib/lintr) package to enforce code style consistency and better / clean code practice.

> It seems that `renv` is ignoring `lintr` so you might need to install it with `install.packages("lintr")`.

Run the linter with `lintr::lint_dir()`

> It is recommended to use the [styler](https://github.com/r-lib/styler) package as well.

**VSCode** users need to install the [`languageserver`](https://github.com/REditorSupport/languageserver) R package and the [R extension](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r) for VSCode.

## How to operate this project?

> TODO

$$the following can also be moved to the wiki if you decide to have one$$

explain how the output(s) of this project can be handled/operated, for example:

-   how to knit the report(s)
-   where to create/find the data visualizations
-   how to update data
-   what would need to be updated if someone wanted to re-run your analysis with different data

## Limitations

be honest about the limitations of your project, e.g.:

-   methodological: maybe another model would be more suitable?
-   reproducibility: what are limits of reproducibility? is there something hard-coded/specific to the data that you used?
-   best practices: maybe some code is particularly messy and people working on it in the future should know about it in advance?
