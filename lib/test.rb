require './ccda-isa-arch'

xmlfile = File.new("ccda.xml")


patient = Iza.new(xmlfile)

puts patient.smoker
puts patient.age