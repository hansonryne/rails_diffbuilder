ActiveJob::Status.store = ActiveSupport::Cache::FileStore.new Rails.root.join('tmp', 'cache', 'jobcache')

