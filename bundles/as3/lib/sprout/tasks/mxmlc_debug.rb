
module Sprout # :nodoc:
  
  # The MXMLCDebug helper wraps up fdb and mxmlc tasks by
  # using either a Singleton or provided ProjectModel instance.
  #
  # The simple case that uses a Singleton ProjectModel:
  #   debug :debug
  #
  # Using a ProjectModel instance:
  #   model = Sprout::ProjectModel.setup
  #
  #   debug :debug => model
  #
  # Configuring the proxy Sprout::MXMLCTask
  #   debug :debug do |t|
  #     t.link_report = 'LinkReport.rpt'
  #   end
  #
  class MXMLCDebug < MXMLCHelper
  
    def initialize(args, &block)
      super
      mxmlc output do |t|
        t.debug = true
        configure_mxmlc t
        configure_mxmlc_application t
        yield t if block_given?
      end

      define_player
      
      t = define_outer_task
      t.prerequisites << player_task_name
    end
    
  end
end

def debug(args, &block)
    return Sprout::MXMLCDebug.new(args, &block)
end
