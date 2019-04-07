define :upsert_job, :job_name => nil do
  ruby_block "update #{params[:job_name]}" do
    block do
      body = IO.read(params[:file_name])
      header = {'Content-Type' => 'text/xml'}.merge(basic_auth).merge(crumb)

      begin
        client.post("/job/#{params[:job_name]}/config.xml", body, header)
      rescue Net::HTTPServerException => e
        if e.message == '404 "Not Found"'
          client.post("/createItem?name=#{params[:job_name]}", body, header)
        else
          raise e
        end
      end
    end
  end
end
