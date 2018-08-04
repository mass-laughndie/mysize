module Search
  def search_fields(*fields, size_field: nil)
    @fields = valid_columns_from(fields)
    @size_field = valid_size_column_from(size_field)
  end

  def search(search_words)
    search_condition(search_words, @fields, @size_field)
  end

  def search_condition(search_words, fields, size_field)
    condition = all
    return condition if search_words.blank?

    keywords = format(search_words)
    keywords.each do |keyword|
      where_phrases = [""]
      where_phrases = where_some_phrases_for(fields, keyword, where_phrases)
      where_phrases = where_size_phrases_for(size_field, keyword, where_phrases)

      condition = condition.where(where_phrases)
    end
    condition
  end

  private

  def valid_columns_from(fields)
    column_names.map(&:to_sym) & fields
  end

  def valid_size_column_from(size_field)
    column_names.map(&:to_sym).include?(size_field) ? size_field : nil
  end

  def format(keywords)
    keywords.downcase.split(/[\s　]+/)
  end

  def where_some_phrases_for(fields, keyword, phrases)
    fields.each do |field|
      phrases[0] += "lower(#{field}) LIKE (?)"
      phrases[0] += " OR " if field != fields[-1]
      phrases << "%#{keyword}%"
    end
    phrases
  end

  def where_size_phrases_for(field = nil, keyword, phrases)
    return phrases if field.nil?
    phrases[0] += " OR #{field} IN (?)"
    phrases << "#{keyword.to_f}"
    phrases
  end
end