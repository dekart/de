require "yaml"

module SshHosts
  class << self
    def host_list_autocomplete
      Dir[File.expand_path('~/.ssh/hosts/**/*.yml')].map{|f| File.basename(f, '.yml') }.sort.each do |file|
        puts file unless file == 'global'
      end
    end

    def remote_command(server, command)
      system %{
        ssh #{server} -t "bash -i -c '. ~/.profile; #{ command }'"
      }
    end

    def remote_rails_folder(server)
      config = server_config(server)

      if config and config['rails_folder']
        config['rails_folder']
      else
        server
      end
    end

    def remote_rails_env(server)
      config = server_config(server)

      if config and config['rails_env']
        config['rails_env']
      else
        'production'
      end
    end

    def server_config(server)
      config_file = Dir[File.expand_path("~/.ssh/hosts/**/#{server}.yml")].first

      YAML.load_file(config_file)[server]['de'] if File.file?(config_file)
    end
  end
end