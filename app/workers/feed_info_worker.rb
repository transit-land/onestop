require 'net/http'

class FeedInfoWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(url, cachekey)
    @url = url
    @cachekey = cachekey
    @progress_checkpoint = 0.0
    # Partials
    progress_downloading = lambda { |count,total| progress_check('downloading', count, total) }
    progress_parsing = lambda { |count,total,entity| progress_check('parsing', count, total) }
    # Download & parse feed
    feed, operators = nil, nil
    errors = []
    response = {}
    begin
      feed_info = FeedInfo.new(url: @url)
      progress_update('downloading', 0.0)
      feed_info.download(progress: progress_downloading) do |feed_info|
        progress_update('downloading', 1.0)
        progress_update('parsing', 0.0)
        feed_info.process(progress: progress_parsing) do |feed_info|
          progress_update('parsing', 1.0)
          progress_update('processing', 0.0)
          feed, operators = feed_info.parse_feed_and_operators
          progress_update('processing', 1.0)
        end
      end
    rescue GTFS::InvalidSourceException => e
      errors << {
        exception: 'InvalidSourceException',
        message: 'This file does not appear to be a valid GTFS feed. Contact Transitland for more help.'
      }
    rescue SocketError => e
      errors << {
        exception: 'SocketError',
        message: 'There was a problem downloading the file. Check the address and try again, or contact the transit operator for more help.'
      }
    rescue Net::HTTPServerException => e
      errors << {
        exception: 'HTTPServerException',
        message: "There was an error downloading the file. The transit operator server responded with: #{e.to_s}.",
        response_code: e.response.code
      }
    rescue StandardError => e
      errors << {
        exception: e.class.name,
        message: 'There was a problem downloading or processing from this URL.'
      }
    else
      response[:feed] = FeedSerializer.new(feed).as_json
      response[:operators] = operators.map { |o| OperatorSerializer.new(o).as_json }
    end
    response[:status] = errors.size > 0 ? 'error' : 'complete'
    response[:errors] = errors
    response[:url] = @url
    Rails.cache.write(@cachekey, response, expires_in: FeedInfo::CACHE_EXPIRATION)
    response
  end

  private

  def progress_check(status, count, total)
    # Update upgress if more than 10% work done since last update
    return if total.to_f == 0
    current = count / total.to_f
    if (current - @progress_checkpoint) >= 0.05
      progress_update(status, current)
    end
  end

  def progress_update(status, current)
    # Write progress to cache
    current = 1.0 if current > 1.0
    @progress_checkpoint = current
    cachedata = {
      status: status,
      url: @url,
      progress: current
    }
    Rails.cache.write(@cachekey, cachedata, expires_in: FeedInfo::CACHE_EXPIRATION)
  end
end

if __FILE__ == $0
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  url = ARGV[0] || "http://www.caltrain.com/Assets/GTFS/caltrain/GTFS-Caltrain-Devs.zip"
  FeedInfoWorker.new.perform(url, 'test')
  puts Rails.cache.read('test').to_json
end
