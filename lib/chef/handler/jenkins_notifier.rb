require "chef/handler/jenkins_notifier/version"
require "chef/log"
require "net/http"
require 'digest/md5'

class Chef
  class Handler
    class Jenkins_Notifier < Chef::Handler
      def initialize(config)
        @config = config
        raise ArgumentError, 'Jenkins URL is not specified' unless @config[:url]
      end

      def report

        log = []
        if not run_status.success?
          result = 1
          log << "\n"
          log << "Chef run failed on #{run_status.node.name}"
          if !run_status.exception.nil?
            log << run_status.formatted_exception.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'})
          end
          log << "\n"
          log = log.join("\n")
          submit_jenkins run_status,log,result
        else
          result = 0
          log << "\n"
          log << "Chef run Success on #{run_status.node.name}"
          log << "environment: " + run_status.node.environment
          log << "start_time: " + run_status.start_time.rfc2822
          log << "end_time: " + run_status.end_time.rfc2822
          log << "elapsed_time: " + run_status.elapsed_time.to_s + "s"
          log << "\n"
          log = log.join("\n")
          submit_jenkins run_status,log,result
        end
      end

      def submit_jenkins(run_status, log, result)
        binlog = log.unpack("H*").first
        ms = (run_status.elapsed_time * 1000).round
        data = "<run><log encoding='hexBinary'>#{binlog}</log><result>#{result}</result><duration>#{ms}</duration></run>"
        http = Net::HTTP.new(@config[:url], @config[:port])
        response = http.post(@config[:path],data)
        #puts response
      end
    end
  end
end
