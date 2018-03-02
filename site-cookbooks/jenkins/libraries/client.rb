def client
  Chef::HTTP.new(node[:jenkins][:host])
end

def crumb
  path = '/crumbIssuer/api/json'
  response = client.get(path, basic_auth)
  {'Jenkins-Crumb' => JSON.parse(response)['crumb']}
end

def basic_auth
  account = node[:jenkins][:accounts].first
  credential = Base64.strict_encode64("#{account[:id]}:#{account[:password]}")
  {'Authorization' => "Basic #{credential}"}
end

def config(env, job)
  File.absolute_path(File.dirname(__FILE__) + "/../files/default/jobs/#{env}/#{job}.xml")
end
