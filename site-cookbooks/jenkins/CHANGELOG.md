# jenkins CHANGELOG

This file is used to list changes made in each version of the jenkins cookbook.

## 1.7.2
- Update jenkins config for production and compute to use Jenkinsfile

## 1.7.1
- Add plugins to enable pipeline
- Update jenkins config for development to use Jenkinsfile

## 1.7.0
- Add jenkins config file to extract race info

## 1.6.2
- Modify jenkins config to update gem if exists

## 1.6.1
- Add parameter for deploy scope
- Update ruby version in jenkins config files

## 1.6.0
- Create jenkins config to import moving averages

## 1.5.5
- Update jenkins config to update ruby version for alterf and zosma

## 1.5.4
- Update jenkins config to add fail-fast option to updating gem jobs

## 1.5.3
- Add jenkins plugin to rebuild a job

## 1.5.2
- Update jenkins config to remove old gems

## 1.5.1
- Update jenkins config not to exit script

## 1.5.0
- Create script to add new version to changelog
- Update jenkins config to update changelog

## 1.4.1
- Update jenkins config to remove branch to update gems

## 1.4.0
- Create directory to put scripts
- Create config file for access to github
- Add jenkins config file to update gems

## 1.3.4
- Update jenkins config for deploying to development environment to specify branch

## 1.3.3
- Update import job of zosma to specify period

## 1.3.2
- Add jenkins config file to import candle stick
- Modify jenkins config of zosma

## 1.3.1
- Update jenkins config for production
- Rename jenkins job and script name

## 1.3.0
- Update jenkins config of zosma
- Update recipe to create job if not exist

## 1.2.5
- Update default recipe to install plugins by remote access API

## 1.2.4
- Modify jenkins config of chort-deploy to install packages

## 1.2.3
- Modify jenkins config of denebola

## 1.2.2
- Modify typo
- Update jenkins version

## 1.2.1
- Update jenkins conf for denebola-deploy

## 1.2.0
- Update recipe to update jobs and views
- Add resource to create jobs and views to default

## 1.1.2
- Remove ::deploy from jenkins config

## 1.1.1
- Fix path setting of aggregation
- Fix cron setting

## 1.1.0
- Create default recipe to install
- Create jenkins config files

## 1.0.9
- Modify jenkins config of alterf and regulus

## 1.0.8
- Add new path for regulus spec to chort.xml

## 1.0.7
- Modify REMOTE_HOST for system test

## 1.0.6
- Add new path for alterf spec to chort.xml

## 1.0.5
- Modify jenkins configs to use rake task for rspec

## 1.0.4
- Add view for algieba

## 1.0.3
- Output log to console

## 1.0.2
- Remove cron from alterf-deploy for development

## 1.0.1
- Add jenkins config file for algieba

## 1.0.0
- Create recipe to create view

## 0.1.5
- Add jenkins config files for alterf

## 0.1.4
- Modify algieba-system_test.xml to add env option

## 0.1.3
- Add jenkins config files for regulus
- Modify jenkins path

## 0.1.2
- Add "make clean" to chort.xml
- Use symlink

## 0.1.1
- Create config by chef

## 0.1.0
- Initial release of jenkins

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
