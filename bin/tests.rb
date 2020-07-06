require 'open-uri'
require 'nokogiri'
require 'pry'

html = <<EOT
  <html>
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">IMPA</h4>
        <p>bla bla impermeabilizante y limpiador de cielorasos</p>
        <div class="table-sm">
          <table class="table">
              <tr>
                  <th>tamano</th>
                  <th>precio</th>
              </tr>
              <tr>
                  <td>1500gr</td>
                  <td>$25.121</td>
              </tr>
              <tr>
                  <td>900gr</td>
                  <td>$2.002</td>
              </tr>
              <tr>
                  <td>500gr</td>
                  <td>$1.500</td>
              </tr>
          </table>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">PEGANTE CERAMICO</h4>
        <p>bla bla pegante para ceramica y buscador de dinero</p>
        <div class="table-sm">
          <table class="table">
              <tr>
                  <th>tamano</th>
                  <th>precio</th>
              </tr>
              <tr>
                  <td>40kg</td>
                  <td>$55.121</td>

              </tr>
              <tr>
                  <td>25kg</td>
                  <td>$15.000</td>
              </tr>
          </table>
        </div>
      </div>
    </div>
  </html>
EOT


def parse_examples #no usable
  doc.css('.card:nth-child(2) h4').text #PEGANTE CERAMICO --> contents of second level bellow card class, in h4 tag
  doc.css('.card:contains("limpiador")').css('h4').text # finds the title of anything that contains "limpiador"
  doc.css('p:contains("limpiador")').text #returns the whole contents of the p which has the term "limpiador"
  doc.css('.card:contains("limpiador")').css('.card-title').text #returns the title of the element which contains "limpiador"
  doc.at_css('.card:contains("limpiador")').text
  doc.css('.card:contains("limpiador")').css('.table.table').css('tr > th[1]').text #returns "tamaño" in the 1st tr > th, wherever exists the "limpiador" term
  ary = []; doc.css('p:contains("bla")').each{|i| ary << i.text} # search all p that contains the term "bla" and populate ary with each of its contents
  ary = []; doc.css('.card:contains("bla")').css('.card-title').each{|i| goal << i.text} # search all .card-title that contains the term "bla" and populate ary with each of its contents
  ary = []; doc.css('p:contains("bla")').each{|i| ary << i.text} # search the text "bla" on all p and populate ary with each of its contents
  ary = []; doc.css('p text()').each{|i| ary << i.text}          # extracts the text from all p and populate ary with each of its contents
  ary = []; doc.css(".card-title text()").each{|i| ary << i.text} # extracts the text from all .card-title and populate ary with each of its contents (same previous)

  # assuming nokorigi object in stored in @doc: (in command line, after oneliner "nokogiri http://..." it creates the @doc)
  @doc.css('card').length #> 161 (from http://precios.paternit.com) => also onliners. nokogiri http://pre....com -e puts @doc.css('img').length
  nokogiri http://precios.paternit.com
  @doc.css(".card-title text()").map(&:text).count # returns the number of strings of each element in the html file => 162
  @doc.css('p:contains("Adhesivo")').map(&:text).count # returns the number of p that contains Adhesivo word => 5
  @doc.css('img').length #number of images in the html doc
  @doc.css('p text()').map(&:text) # returns an array with all p contents, same as line 75 and 86
  @doc.at_css('p').content # returns contents of the first node with a p
  @doc.css('p').map(&:text)
  # work with text inside p's. they need to get rid of white spaces and line jumps
  z = @doc.css('p:contains("Adhesivo")').map(&:text) # fills z array only with inner text from p that contains "Adhesivo"
  z.each {|i| i.gsub!('  ','')}                      # removes all pairs of white space
  z.each {|i| i.gsub!('\n',' ')}                     # removes all /n and replaces with a space

  @doc.search('//text()').map(&:text).delete_if{|x| x !~ /\w/}
  @doc.at_css('p').children.text # extracts text from p

  @doc.text.gsub("\n", ' ').gsub("\t", ' ').split.join(' ')  #cleans text
  @doc.at_css('h2 a').content.gsub(/\n/," ").strip # => "Ex-Worker at C.I.A. Says He Leaked Data on Surveillance"
  
  titles_array = @doc.search('.container .card .card-title').map(&:text)
  stripped_titles_array = titles_array.map {|i| i.gsub("\n", ' ').gsub("\t", ' ').split.join(' ')}

  description_array = @doc.search('.container .card .card-title').map(&:text) # q = all p dirty
  stripped_description_array = titles_array.map {|i| i.gsub("\n", ' ').gsub("\t", ' ').split.join(' ')}
  
  all_cells = []
  @doc.at('table').search('tr').each do |row|
    print row.search('th, td[1]').map(&:text)
    print cells = row.search('th[2], td[2]').map(&:text)
  end
  puts "-----------PRICE TABLE-------------"
  print a = @doc.at('table').search('tr > th[1]').map(&:text)
    print "   --|--   "
  puts b = @doc.at('table').search('tr > th[2]').map(&:text)
  a = @doc.at('table').search('tr').each do |row|
      puts "-----------------------------------"
      print c = row.search('th, td[1]').map { |cell| cell.text.ljust(15).strip } #or better yet, (&:text)
      print d = row.search('th, td[2]').map { |cell| cell.text.ljust(15).strip }
    end
    @doc.css('.descrip text()').css('p:contains("Adhesivo")')
  end
  # ["Tamaños"]
  # ["Cuñete", "$665.000"]
  # ["Galón", "$150.000"]
  # ["¼ Galón", "$52.500"]
  # ["1/8", "$29.000"]
  # ["1/16", "$17.000"]
  # ["1/32", "$11.500"]
end

def align_example #no usable
  names_with_ages = [["john", 20], ["peter", 30], ["david", 40], ["angel", 24]]
  names_with_ages.each { |name, age| puts name.ljust(10) + age.to_s }
  # Prints the following table
  john      20
  david     30
  peter     40
  angel     24
end

doc = Nokogiri::HTML(html)

# rows = tables.css('tr')
tables = doc.css('div.table-sm > table.table') #start search on tables
term = doc.css
count = 0 

tables_data = []
tables.each do |table|
  count = 2
  c = 1
  raw_name = table.css("tr > th[#{count}]").text #gets the tr > th (headings(size- price))
  cell_data = table.css("tr[#{c}] > td[#{count}]").text  # gets the contents of th > td 
  tables_data << [raw_name, cell_data]
end
p tables_data   # [["tamanoprecio", "1500gr$25.121900gr$2.002500gr$1.500"], ["tamanoprecio", "40kg$55.12125kg$15.000"]]
p tables_data[0] # ["tamanoprecio", "1500gr$25.121900gr$2.002500gr$1.500"]
puts "----------"
p tables_data[1]  # ["tamanoprecio", "40kg$55.12125kg$15.000"]

#fetch siblings - parent