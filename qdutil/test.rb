require '../lib/ccda-iza'

xmlfile = File.new("../lib/ccda.xml")


patient = Iza.new(xmlfile)

#puts patient.smoker
#puts patient.age
# puts patient.to_json
#puts patient.gender
#puts patient.zipcode
puts patient.payerpayload


#puts patient.to_hash