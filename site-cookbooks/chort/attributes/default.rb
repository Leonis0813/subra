default[:chort][:app_name] = 'chort'
default[:chort][:deploy_dir] = "/opt/nginx/docs/#{default[:chort][:app_name]}"
default[:chort][:repository] = "https://github.com/Leonis0813/#{default[:chort][:app_name]}.git"
default[:chort][:branch] = 'develop'
default[:chort][:doc_names] = %w[ fx-rate_estimator horse-race_estimator payment_manager ]
