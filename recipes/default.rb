#
# Cookbook Name:: opsworks-export-envs
# Recipe:: default
#
# Copyright 2015, HiganWorks LLC
#
# All rights reserved - Do Not Redistribute
#

node.deploy.each_pair do |app_name,vals|
  file File.join("/etc/profile.d/", "shellinit-#{app_name}.sh") do
    envs = []
    vals.environment_variables.each_pair {|key, val| envs << "export #{key}=\"#{val}\""} if vals.environment_variables
    owner vals[:user]
    group vals[:group]
    mode node[:opsworks_export_envs][:filemode]
    content envs.join("\n")
  end
end
