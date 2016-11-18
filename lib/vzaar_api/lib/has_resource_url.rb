module VzaarApi
  module Lib
    module HasResourceUrl

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def resource_url(path = nil)
          Api.resource_url self::ENDPOINT, path
        end
      end

    end
  end
end

__END__
module Supersedable
  # Supersedable services can be run by another worker before their invocation
  # (for example due to retries succeeding)

  def self.included(base)
    base.prepend(InstanceMethods)
  end

  module InstanceMethods
    def execute
      jobs = workflow.workflow_jobs.finished.where(job_type: self.class::JOB_TYPE)
      if jobs.any?
        job.update_attribute(:name, "superseded by #{jobs.first.id}")
        job.skip!
      else
        super
      end
    end
  end
end
