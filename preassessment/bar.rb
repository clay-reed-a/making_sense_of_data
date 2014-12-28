require 'csv'
require 'awesome_print'
require 'gchart'
require 'securerandom'

NegativeInfinity = -1.0/0.0
bestseller_sale = NegativeInfinity

                  # I tried using  
                        (bestseller_sale * 1.15)#round    
                  # for y-axis height... 

class String 
  def titleize # Hip hop 
     self.split.map(&:capitalize).join ' '
  end 
end 

table = CSV.read 'Music Records Data.csv', headers: true 

histo_hash = {} 

table.each do |row|
  genre = row['Genre'].titleize
  year = row['Release Year'].to_i
  sales = row['Total Record Sales'].to_i 

  if sales > bestseller_sale
    bestseller_sale = sales  
  end 

  # if ((year > 1974 ) && (year < 2000))  
    if histo_hash.has_key? genre 
      histo_hash[genre][:years] << year
      histo_hash[genre][:total] += sales 
      histo_hash[genre][:albums] += 1
      histo_hash[genre][:average] = histo_hash[genre][:total] / histo_hash[genre][:albums]
    else 
      histo_hash[genre] = {}
      histo_hash[genre][:years] = [year]
      histo_hash[genre][:total] = sales 
      histo_hash[genre][:albums] = 1 
      histo_hash[genre][:average] = histo_hash[genre][:total]
    end
  # end  
end 

ap histo_hash 
 
bar_chart = Gchart.new(
            type: 'bar',
            size: '125x400', 
            bar_colors: SecureRandom.hex[0,6], 
            bg: 'EFEFEF',
            data: histo_hash.values.map { |data| data[:average] },
            filename: 'bar_chart.png',
            axis_with_labels: [['x']],   
            axis_labels: [[histo_hash.keys.join('|')]]
          ) 

bar_chart.file 