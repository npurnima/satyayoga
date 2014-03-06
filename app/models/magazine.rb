class Magazine < ActiveRecord::Base
  attr_accessible :title, :filepath, :coverpageimage, :languagewritten, :datewritten,:month, :year, :owner

  belongs_to :user,
             :class_name => 'User',
             :foreign_key => 'owner'

  validates_presence_of :filepath, :title

  validates_format_of :coverpageimage, :with    => %r{\.(gif|jpg|png|jpeg)$}i, :allow_blank => true,
                      :message => "Must be a URL for a GIF, JPG, or PNG image"

  MONTHS = [['January',1], ['February',2], ['March',3], ['April',4], ['May',5], ['June',6],
            ['July',7], ['August',8], ['September',9],['October',10],['November',11],['December',12]]
   YEARS = []
  def self.select_years
    (0..10).each do |y|
      YEARS << Date.today.year-y
      logger.debug("#{YEARS}")
      logger.debug("#{Date.today.year-y}")
    end
    YEARS
  end

  def self.get_month(m)
    case m
      when 1
         return "January"
      when 2
        return "February"
      when 3
        return "March"
      when 4
       return "April"
      when 5
        return "May"
      when 6
        return "June"
      when 7
        return "July"
      when 8
        return "August"
      when 9
        return "September"
      when 10
        return "October"
      when 11
        return "November"
      when 12
        return "December"
      else
        return "Any other thing"
    end
  end

  def self.find_all_magazine_years(lang)
    if connection.adapter_name == 'PostgreSQL'
         @years = Magazine.where("languagewritten =  ?",lang).select('DISTINCT(year)')

    else
      @years = Magazine.where("languagewritten =  ?",lang).group("year")
    end
     @years
  end

  def self.find_latest_two
     @magazines = Magazine.where(("year = max(year)").order("(month)").limit(2))
  end

  def self.find_latest_telugu

      @magazines = Magazine.where(("languagewritten  = 'Telugu'"),("year = max(year)")).order("(month)").limit(1)

     @magazines
  end
  def self.find_latest_english

      @magazines = Magazine.where(("languagewritten = 'English'"),("year = max(year)")).order("(month)").limit(1)

      @magazines
  end

  def self.find_telugu_archives(year)

      @magazines = Magazine.where("languagewritten = ? and year = ? ",'Telugu',year) .order("month")

    return @magazines
  end

  def self.find_english_archives(year)

    if connection.adapter_name == 'PostgreSQL'
      @magazines = Magazine.where("\"languagewritten\"" " = ? and year = ? ",'English',year) .order("month")
    else
      @magazines = Magazine.where("languagewritten = ? and year = ? ",'English',year) .order("month")
    end
     return @magazines
  end

  def self.find_user_magazines(userid)

      @magazines = Magazine.where("owner=?",userid).order("year")

    @magazines
  end

end

