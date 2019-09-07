# regulus CHANGELOG

This file is used to list changes made in each version of the regulus cookbook.

## 2.3.0
- Update default recipe to install geckodriver and upgrade firefox
- Remove resource for lokkit from default recipe
- Stop installing docker for tensorflow and install to virtualenv

## 2.2.2
- Update recipe to deploy for production

## 2.2.1
- Update ruby version
- Update recipe to install specific bundler version

## 2.2.0
- Update recipe for crontab setting

## 2.1.9
- Fix tensorflow version tag

## 2.1.8
- Update attribute to install python package

## 2.1.7
- Update deploy recipe to install cmake

## 2.1.6
- Fix coding style

## 2.1.5
- Update ruby version

## 2.1.4
- Clean old gems when installing gems
- Update ruby version

## 2.1.3
- Add shared directory to output zip file
- Remove unuse shared directory

## 2.1.2
- Add shared directory for saving models to tmp

## 2.1.1
- Update settings.yml.erb to add database

## 2.1.0
- Remove recipe to install ruby
- Update recipes to create environment for tensorflow
- Create template for action mailer

## 2.0.1
- Update default recipe to specify firefox version

## 2.0.0
- Create recipe to deploy app
- Refactor default recipe

## 1.5.1
- Modify recipe to create db

## 1.5.0
- Add package install for development to default recipe
- Open ports for tcp

## 1.4.0
- Remove files created in zosma

## 1.3.0
- Update recipe for deploy to create web server

## 1.2.0
- Create settings.yml
- Create shared directory for learning results

## 1.1.0
- Remove recipe for cron

## 1.0.1
- Encrypt credentials and IP addresses

## 1.0.0
- Create recipe for nfs mount

## 0.3.0
- Add weekday setting to cron

## 0.2.1
- Not execute bundle install for compute environment

## 0.2.0
- Remove cron for deleting rate

## 0.1.0
- Initial release of regulus

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
