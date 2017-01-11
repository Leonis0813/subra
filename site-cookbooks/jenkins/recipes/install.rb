#
# Cookbook Name:: jenkins
# Recipe:: install
#
# Copyright 2017, Leonis0813
#
# All rights reserved - Do Not Redistribute
#
yum_repository 'jenkins' do
  description 'Jenkins stable repository'
  baseurl 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
  gpgkey 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key'
end
