define :mysql_query, query: nil, query_type: 'file', user: 'root', password: nil, table: nil do
  password = params[:password] || node[:mysql][:root_password]

  query = case params[:query_type]
          when 'file'
            file_path = File.absolute_path("#{File.dirname(__FILE__)}/../files/default/#{params[:query]}")
            File.read(file_path).chomp
          when 'string'
            params[:query]
          end

  execute params[:name] do
    command "mysql -u #{params[:user]} -p#{password} #{params[:table].to_s} -e '#{query}'"
  end
end
