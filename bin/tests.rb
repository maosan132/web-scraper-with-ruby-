# frozen_string_literal: true

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

doc = Nokogiri::HTML(html)

# rows = tables.css('tr')
tables = doc.css('div.table-sm > table.table') # starts earch on tables
term = doc.css
# doc.css('.card:nth-child(2) h4').text #PEGANTE CERAMICO --> contents of second level bellow card class, in h4 tag
# doc.css('.card:contains("limpiador")').css('h4').text # finds the title of anything that contains "limpiador"
# doc.css('p:contains("limpiador")').text #returns the whole contents of the p which has the term "limpiador"
# doc.css('.card:contains("limpiador")').css('.card-title').text #returns the title of the element which contains "limpiador"
doc.at_css('.card:contains("limpiador")').text
# doc.css('.card:contains("limpiador")').css('.table.table').css('tr > th[1]').text #returns "tamaño" in the 1st tr > th, wherever exists the "limpiador" term
# ary = []; doc.css('p:contains("bla")').each{|i| ary << i.text} # search all p that contains the term "bla" and populate ary with each of its contents
# ary = []; doc.css('.card:contains("bla")').css('.card-title').each{|i| goal << i.text} # search all .card-title that contains the term "bla" and populate ary with each of its contents
# ary = []; doc.css('p:contains("bla")').each{|i| ary << i.text} # search the text "bla" on all p and populate ary with each of its contents
# ary = []; doc.css('p text()').each{|i| ary << i.text}          # extracts the text from all p and populate ary with each of its contents
# ary = []; doc.css(".card-title text()").each{|i| ary << i.text} # extracts the text from all .card-title and populate ary with each of its contents (same previous)

count = 0

tables_data = []
tables.each do |table|
  count = 2
  c = 1
  raw_name = table.css("tr > th[#{count}]").text # gets the tr > th (headings(size- price))
  cell_data = table.css("tr[#{c}] > td[#{count}]").text # gets the contents of th > td
  tables_data << [raw_name, cell_data]
end
p tables_data # [["tamanoprecio", "1500gr$25.121900gr$2.002500gr$1.500"], ["tamanoprecio", "40kg$55.12125kg$15.000"]]
p tables_data[0] # ["tamanoprecio", "1500gr$25.121900gr$2.002500gr$1.500"]
puts '----------'
p tables_data[1] # ["tamanoprecio", "40kg$55.12125kg$15.000"]

# fetch siblings - parent
