[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

# Data to Metabase: Automated Curation with the Metabase API

## What is this project about?

One of two Metabase-centric projects (see [Metabase-to-Google](https://github.com/CorrelAid/metabase-to-google)).
This project will explore automated approaches to (pre-)curating a Metabase instance with Dashboards
and queries through the [Metabase API](https://www.metabase.com/docs/latest/api-documentation).


## Who is this project for?

Individuals and organizations that already use Metabase as their data visualisation tool, who have some prior knowledge using R and who have a need for automation when creating dashboards and queries.


## Setup

1. Install R and R-Studio. See [below](#r-installation) for help.

1. Make sure you have access to a Metabase instance. For setting up a local instance see [below](#local-metabase-development-instance) for help.

1. Configure the connection betwen the R-Project and Metabase. See [below](#r-metbase-configuration) for help.

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

- `renv` brings project-local R dependency management to our project.
- `renv` uses a lockfile (`renv.lock`) to capture the state of your library at some point in time.
- Based on `renv.lock`, RStudio should automatically recognize that it's being needed, thereby downloading and installing the appropriate version of `renv` into the project library.

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

### Local Metabase Development Instance

The easiest way to try out the R functionality is by connecting to a remote Metabase instance one has access to.
if this is the case for you skip ahead to [R-Metabase Configuration](#r-metbase-configuration).

In the absence of access to a remote metabase instance, it is possible to run the open source deployment
of Metabase locally using docker. This can be connected to in the same way connections to a remote instance work.

To set it up

1.  Install Docker or Docker Desctop following the [installation instructions on the docker site](https://docs.docker.com/engine/install/)

1.  Follow the [running metabase in docker instructions](https://www.metabase.com/docs/latest/installation-and-operation/running-metabase-on-docker) which we repeat for simplicity.

        docker pull metabase/metabase:latest
        docker run -d -p 3000:3000 --name metabase metabase/metabase

1.  In you browser go to `localhost:3000`

1.  Follow the setup instructions. Note the email and password in order to connect with R. You can also Skip the step that lets you connect your own database.
    Metabase will still have example data available, which is enough to try the R functionality. Any changes however will not persist if the docker container is
    removed.

This completes the setup of a local metabase instance. The next section describes how to connect it to the R project.


### R-Metabase Configuration 

If you have access to a metabase instance, either remotely or locally via docker you need confiugre the connection to the R project.

1. In the terminal, navigate to the DataToMetabase project folder

1.  Create a `.Renviron` file from the `.Renviron.example` template.

        cp .Renviron.example .Renviron

1.  Open `.Renviron` in a text editor

1.  Provide your Metabase credentials and the metabase url. The latter is `localhost:3000` in case you are using the local docker instance with the default port. Before filling the file should look like.

        METABASE_USER="<email>"
        METABASE_PWD="<password>"
        METABASE_URL="<metabase-url>"

1.  Start R-Studio and open the project.

1.  Load the project as a package

        devtools::load_all()

1.  Create a metabase client instance and show all the metabase databases. If this runs without error and shows the sample database the configuration is correct.

        mc <- MetabaseClient()
        mc$get_databases()

## Developer Information

### Code styling

#### Linting

This project uses the [`lintr`](https://github.com/r-lib/lintr) package to enforce code style consistency and better / clean code practice.

> It seems that `renv` is ignoring `lintr` so you might need to install it with `install.packages("lintr")`.

Run the linter with `lintr::lint_dir()`

> It is recommended to use the [styler](https://github.com/r-lib/styler) package as well.

**VSCode** users need to install the [`languageserver`](https://github.com/REditorSupport/languageserver) R package and the [R extension](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r) for VSCode.

# Partner organization

This project was conducted in collaboration with the [Vielfalt entscheidet](https://citizensforeurope.org/advocating_for_inclusion_page/) project of Citizens For Europe gUG. 


[contributors-shield]: https://img.shields.io/github/contributors/CorrelAid/DataToMetabase.svg?style=for-the-badge
[contributors-url]: https://github.com/CorrelAid/DataToMetabase/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/CorrelAid/DataToMetabase.svg?style=for-the-badge
[forks-url]: https://github.com/CorrelAid/DataToMetabase/network/members
[stars-shield]: https://img.shields.io/github/stars/CorrelAid/DataToMetabase.svg?style=for-the-badge
[stars-url]: https://github.com/CorrelAid/DataToMetabase/stargazers
[issues-shield]: https://img.shields.io/github/issues/CorrelAid/DataToMetabase.svg?style=for-the-badge
[issues-url]: https://github.com/CorrelAid/DataToMetabase/issues
[license-shield]: https://img.shields.io/github/license/CorrelAid/DataToMetabase.svg?style=for-the-badge
[license-url]: https://github.com/CorrelAid/DataToMetabase/blob/master/LICENSE.md
