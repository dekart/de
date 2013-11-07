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
      config_file = Dir[File.expand_path("~/.ssh/hosts/**/#{server}.yml")].first

      if File.file?(config_file)
        config = YAML.load_file(config_file)[server]

        if config['de'] and config['de']['rails_folder']
          return config['de']['rails_folder']
        end
      end

      server
    end
  end
end