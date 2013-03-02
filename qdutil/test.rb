require '.lib/ccda-iza'

xmlfile = File.new("lib/ccda.xml")


patient = Iza.new(xmlfile)

puts patient.smoker
puts patient.age