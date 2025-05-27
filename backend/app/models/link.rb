class Link < ApplicationRecord
  validates :original_url, presence: true, format: URI.regexp(%w[http https]) # can be improved
  validates :short_path, uniqueness: true 

  before_validation :normalize_url
  before_create :generate_short_path

  def short_url
    Rails.application.routes.url_helpers.short_url(short_path)
  end

  private

  # prevents blank data from generating a new link
  # URI parsing allows url to be more granularly used when needed (e.g. for filtering query params etc.)
  # URI ensures that invalid URIs raise an exception
  def normalize_url
    return if original_url.blank?
    uri = URI.parse(original_url)
    self.original_url = uri.to_s
  rescue URI::InvalidURIError
    errors.add(:original_url, 'is not a valid URL')
  end

  # generates a unique short url until one exists
  def generate_short_path
    loop do
      self.short_path = SecureRandom.urlsafe_base64(6)
      break unless Link.exists?(short_path: short_path)
    end
  end
end
