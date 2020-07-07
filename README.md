# README

### Description
A tool to help with differential code review.

## Docker Installation

Clone and move into the repository
```
git clone https://github.com/hansonryne/rails_diffbuilder
cd rails_diffbuilder
```

Configure environment files (.env)
```
touch .env
```

Add the following environment variables to .env
```
# These values should be changed to a more secure value and then updated to match in the init.sql file in this repository
DATABASE_USER=sammy
DATABASE_PASSWORD=shark
DATABASE_NAME=diffbuilder_db
DATABASE_HOST=database
RAILS_ENV=development
RAILS_SERVE_STATIC_FILES=true
# You should make this better too
SECRET_KEY_BASE=supers3cr3tpassword
#Point Bundler at /gems. This will cause Bundler to re-use gems that have already been installed on the gems volume
#BUNDLE_PATH=/gems
#BUNDLE_HOME=/gems
# Increase how many threads Bundler uses when installing. Optional!
BUNDLE_JOBS=4
# How many times Bundler will retry a gem download. Optional!
BUNDLE_RETRY=3
# Where Rubygems will look for gems, similar to BUNDLE_ equivalents.
#GEM_HOME=/gems
#GEM_PATH=/gems
POSTGRES_DB=diffbuilder_db
POSTGRES_USER=sammy
POSTGRES_PASSWORD=shark
```

Run containers in daemon mode
```
docker-compose up -d
```

**App should be running on localhost:3000**

When you are done, shut down and clean up with docker-compose
```
docker-compose down
```

Database should remain in docker volumes

# Basic Use
## Creating a repository
Repositories can be either on the local machine or accessible via a remote git service (Github/Gitlab/etc.).

Remote repositories can be added by simply using their public URL in the "Repo location" field.

![](https://github.com/hansonryne/assets/blob/master/diffbuilder/new_repo.png?raw=true)

Local repositories must be saved within the scope of the application. Typically using the "storage" directory works best since this directory is in the .gitignore file.

For example:
```
cp -R /path/to/your/repo {ProjectRoot}/storage/
```

Then the "Repo location" field in the application would be 'storage/your_repo'

**Large repositories may take a while for the application to process so be patient.**

## Creating a review
 Once a repository is saved to the application, reviews can be made. Most of the fields are self explanatory, but to ensure desired results, know that the **commit selection boxes are ordered from oldest commit to newest commit, top to bottom**.

 ![](https://github.com/hansonryne/assets/blob/master/diffbuilder/new_review.png?raw=true)

## Working with Diffs
Once a review is created, the files that changed between commits are listed on the "Show Review" page in dropdown tags. Files can be filtered by their review status of either "Not reviewed", "Vulnerable", "Complete", or "Ignored".

![](https://github.com/hansonryne/assets/blob/master/diffbuilder/view_review.png?raw=true)

To review a file, click on the filename.

Once in the file, you can change the status, update notes, or go back to the review.

![](https://github.com/hansonryne/assets/blob/master/diffbuilder/view_diff.png?raw=true)

**Occasionally the fill diff will not show up right away and the page must be reloaded.**
