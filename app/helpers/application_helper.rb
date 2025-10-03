module ApplicationHelper
  def google_book_thumbnail(google_book)
    google_book.dig('volumeInfo', 'imageLinks', 'thumbnail') || 'sample_thumbnail.jpeg'
  end

  def build_google_book_params(google_book)
    volume = google_book['volumeInfo']

    volume['bookImage'] = volume.dig('imageLinks', 'thumbnail')&.gsub('http', 'https')

    identifier = volume['industryIdentifiers']&.find { |h| h['type'].include?('ISBN') }&.dig('identifier')
    volume['systemid'] = identifier.presence || google_book['id']

    volume.slice('title', 'authors', 'publishedDate', 'description', 'bookImage', 'systemid', 'pageCount')
  end
end
