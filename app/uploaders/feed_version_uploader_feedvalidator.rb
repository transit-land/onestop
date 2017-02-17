class FeedVersionUploaderFeedvalidator < FeedVersionUploader
  def filename
    return unless file
    "#{model.sha1}-feedvalidator.#{file.extension}"
  end

  def extension_white_list
    %w(html)
  end
end
