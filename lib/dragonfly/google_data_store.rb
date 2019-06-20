require 'dragonfly/google_data_store/version'
require 'dragonfly'
require 'google/cloud/storage'

module Dragonfly
  class GoogleDataStore
    attr_reader :project, :keyfile, :bucket_name, :root_path

    def initialize(opts)
      @project = opts[:project]
      @keyfile = opts[:keyfile]
      @bucket_name = opts[:bucket]
      @root_path = opts[:root_path]
    end

    def write(object, opts = {})
      ensure_bucket_exists

      uid = opts[:path] || Dragonfly::GoogleDataStore.generate_uid

      bucket.create_file(
        object.tempfile.path,
        full_path(uid),
        metadata: object.meta,
        content_type: object.mime_type
      )

      uid
    end

    def read(uid)
      file = bucket.file full_path(uid)

      metadata = file.metadata.dup
      metadata['name'] ||= File.basename(file.name)

      content = file.download
      content.rewind

      [content.read, metadata]
    rescue StandardError
      nil
    end

    def destroy(uid)
      file = bucket.file full_path(uid)
      file.delete
    rescue StandardError
      nil
    end

    def self.generate_uid
      "#{Time.now.strftime('%Y/%m/%d/%H/%M')}/#{SecureRandom.uuid}"
    end

    private

    def full_path(uid)
      File.join *[root_path, uid].compact
    end

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
