require 'csv'
require 'nyaplot'

table = CSV.read 'Music Records Data.csv', headers: true 

data = {
                years: [], 
               totals: []
              }

table.each do |row|
 
  year = row['Release Year'].to_i
  sales = row['Total Record Sales'].to_i 
   
  data[:years] << year 
  data[:totals] << sales 
end 

 
 



scatter_plot = Nyaplot::Plot.new
scatter_plot.add(:scatter, data[:years], data[:totals])
scatter_plot.export_html