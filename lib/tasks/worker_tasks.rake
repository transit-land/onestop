task :enqueue_feed_fetcher_workers, [] => [:environment] do |t, args|
  begin
    workers = FeedFetcherService.fetch_all_feeds_async
    if workers
      puts "FeedEaterWorkers #{workers} created and enqueued."
    else
      raise 'FeedEaterWorker could not be created or enqueued.'
    end
  rescue
    puts "Error: #{$!.message}"
    puts $!.backtrace
  end
end

task :enqueue_feed_eater_worker, [:feed_onestop_id, :feed_version_sha1, :import_level] => [:environment] do |t, args|
  begin
    import_level = (args.import_level || 0).to_i # default import level
    feed_eater_worker = FeedEaterWorker.perform_async(args.feed_onestop_id, args.feed_version_sha1, import_level)
    if feed_eater_worker
      puts "FeedEaterWorker ##{feed_eater_worker} has been created and enqueued."
    else
      raise 'FeedEaterWorker could not be created or enqueued.'
    end
  rescue
    puts "Error: #{$!.message}"
    puts $!.backtrace
  end
end

task :enqueue_next_feed_versions, [:date] => [:environment] do |t, args|
  args.with_defaults(date: nil)
  date = args.date ? Date.parse(args.date) : DateTime.now
  max_imports = (Figaro.env.enqueue_next_feed_versions_max.presence || 0).to_i
  Feed.enqueue_next_feed_versions(date, max_imports: max_imports)
end
