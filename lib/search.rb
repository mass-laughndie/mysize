module Search

  # 削除予定
  def self.search(search_words, fields)
    return all unless search_words.blank?

    keywords = format(search_words)
    size_keyword = keywords[0].to_f
    cond = where(["lower(name) LIKE (?) OR lower(mysize_id) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
            "%#{keywords[0]}%", "%#{keywords[0]}%", "%#{keywords[0]}%", "#{size_keyword}"])
    for i in 1..(keywords.length - 1) do
      size_keyword = keywords[i].to_f
      cond = cond.where(["lower(name) LIKE (?) OR lower(mysize_id) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
            "%#{keywords[i]}%", "%#{keywords[i]}%", "%#{keywords[i]}%", "#{size_keyword}"])
    end
    cond
  end

  # 作成中
  def self.search(search_words, fields)
    return all unless search_words.blank?

    keywords = format(search_words)
    size_keyword = keywords[0].to_f
    cond = where(["lower(name) LIKE (?) OR lower(mysize_id) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
            "%#{keywords[0]}%", "%#{keywords[0]}%", "%#{keywords[0]}%", "#{size_keyword}"])
    for i in 1..(keywords.length - 1) do
      size_keyword = keywords[i].to_f
      cond = cond.where(["lower(name) LIKE (?) OR lower(mysize_id) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
            "%#{keywords[i]}%", "%#{keywords[i]}%", "%#{keywords[i]}%", "#{size_keyword}"])
    end
    cond
  end

  private

  def format(keywords)
    keywords.downcase.split(/[\s　]+/)
  end
end