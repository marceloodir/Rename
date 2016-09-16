# encoding: UTF-8

require 'fileutils'
require 'csv' #abrir csv
require 'brstring' #para transformações maiuscula com caracteres latinos.

EVENTO = 'PARTICIPANTES-I-ENCONTRO-apresen-trab' #alterar para cada tipo de certificado emitido
EXTENSAO = '.cdr'
LISTA = 'nomes.csv'
contador = 1

array_nomes = CSV.read(LISTA) # return an Array of Arrays

Dir.glob("*.cdr").sort.each do |entry|
  origin = File.basename(entry, File.extname(entry))
  indice = origin.split('-').last.to_i
  #squish corta espaços desnecessários e upcase converte tudo em caixa alta
  nomes = array_nomes[indice-1][0].split(' - ')
  nomes.each do |cada_nome| #Para mais de uma pessoa para o mesmo certificado
    novo_nome = cada_nome + '-' + EVENTO + contador.to_s + EXTENSAO
    puts 'copiando '+ entry +' para '+ novo_nome
    FileUtils.cp entry, novo_nome
  end
  contador += 1
end
