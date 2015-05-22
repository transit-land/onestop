class FeedEaterWorker
  include Sidekiq::Worker

  PYTHON = './virtualenv/bin/python'

  def perform(feed_onestop_ids = [])
    # TODO: datastore_api_base_url = Figaro.env.DATASTORE_PROTOCOL + "://" + Figaro.env.DATASTORE_HOST +
    logger.info '0. Fetching latest transitland-feed-registry'
    TransitlandClient::FeedRegistry.repo(force_update: true)

    logger.info '1. Checking for new feeds'

    feedids = run_python_and_return_stdout('./lib/feedeater/check.py', feed_onestop_ids.join(' '))
    if feedids
      feedids = feedids.split()
    else
      feedids = []
    end
    logger.info " -> #{feedids.join(' ')}"
    if feedids.length == 0
      return
    end

    # TODO: Child jobs
    for feed in feedids
      logger.info "2. Downloading feed: #{feed}"
      run_python_and_return_stdout('./lib/feedeater/fetch.py', feed)

      logger.info "3. Validating feed: #{feed}"
      run_python_and_return_stdout('./lib/feedeater/validate.py', feed)

      logger.info "4. Uploading feed: #{feed}"
      run_python_and_return_stdout('./lib/feedeater/post.py', feed)

      # TODO: trigger GTFS feed generator job

      # logger.info '6. Creating FeedEater Reports'
      # logger.info '7. Uploading to S3'
      # aws s3 sync . s3://onestop-feed-cache.transit.land
    end

  end

  private

  def run_python_and_return_stdout(file, args)
    `#{PYTHON} #{file} #{args}`
  end
end
