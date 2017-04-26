require 'dragonfly/google_data_store/version'
require 'dragonfly'
require 'google/cloud/storage'

module Dragonfly
  class GoogleDataStore
    attr_reader :project, :keyfile, :bucket_name

    def initialize(opts)
      @project = opts[:project]
      @keyfile = opts[:keyfile]
      @bucket_name = opts[:bucket]
    end

    def write(object, opts = {})
      ensure_bucket_exists

      uid = opts[:path] || Dragonfly::GoogleDataStore.generate_uid

      bucket.create_file object.tempfile.path, uid, metadata: object.meta

      uid
    end

    def read(uid)
      file = bucket.file uid
      content = file.download
      content.rewind
      [
        content.read,
        file.metadata,
      ]
    rescue
      nil
    end

    def destroy(uid)
      bucket.file(uid).delete
    rescue
      nil
    end

    def self.generate_uid
      "#{Time.now.strftime('%Y/%m/%d/%H/%M')}/#{SecureRandom.uuid}"
    end

    private

    def bucket
      @bucket ||= storage.bucket(bucket_name)
    end

    def ensure_bucket_exists
      storage.create_bucket(bucket_name) unless bucket
    end

    def storage
      @storage ||= Google::Cloud::Storage.new(project: project, keyfile: keyfile)
    end
  end
end

Dragonfly::App.register_datastore(:google) { Dragonfly::GoogleDataStore }
