require 'rexml/document'
require 'date'
require 'crack'
require 'json'

#myXML  = Crack::XML.parse(File.read("my.xml"))
#myJSON = myXML.to_json

include REXML

class Iza
  
  def initialize(xmlfile)
    xmldoc = Document.new(xmlfile)
    @xml_doc = xmldoc
    #Crack::XML.parse(xmldoc)
    @xml_json = Crack::XML.parse(@xml_doc.to_s)
    @xml_json_hash = JSON.parse(@xml_json.to_json)   
  end
  
  # PATIENT INFORMATION IMPORTANT TO INSURANCE COMPANIES
  
  def smoker
    
   
   smokingCodes = { '449868002' => 'Current Every Day Smoker',
          '428041000124106' => 'Current some day smoker',
          '8517006' =>  'Former smoker',
          '266919005' =>  'Never smoker',
          '77176002' => 'Smoker current status unknown',
          '266927001' => 'Unknown if ever smoked', 
          '428071000124103' => 'Heavy tobacco smoker',
          '428061000124105' => 'Light tobacco smoker' }
    
   codeXpath = "/ClinicalDocument[1]/component[1]/structuredBody[1]/component[14]/section[1]/entry[1]/observation[1]/value[1]/@code"
   smoking = XPath.first(@xml_doc, codeXpath)
   #puts smoking

   smoking = smokingCodes["#{smoking}"] + "(#{smoking})"
   # puts "Smoking: " + smoking.to_s.chop!
   puts smoking  
  end
  
  
  def age
    
  
  codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/patient[1]/birthTime[1]/@value"
  dob = XPath.first(@xml_doc, codeXpath)
  
  dob = DateTime.parse(dob.to_s)
  age = ((Date.today - dob).to_i / 365.25).ceil
  #birthyear = Date.strptime age, '%m%d%Y'
  
  puts "Age: " + age.to_s
  
    
  end
  
  def gender
    
    codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/patient[1]/administrativeGenderCode[1]/@displayName"
    gender = XPath.first(@xml_doc, codeXpath)
    
    puts "Gender: " + gender.to_s
    
  end
  
  def zipcode
    
    codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/addr[1]/postalCode[1]/node()[1]"
    zipcode = XPath.first(@xml_doc, codeXpath)
    
    puts "Zipcode: " + zipcode.to_s
    
  end
  
  # CORE RETURNS
  
  def payerpayload
   
    smokingCodes = { '449868002' => 'Current Every Day Smoker',
            '428041000124106' => 'Current some day smoker',
            '8517006' =>  'Former smoker',
            '266919005' =>  'Never smoker',
            '77176002' => 'Smoker current status unknown',
            '266927001' => 'Unknown if ever smoked', 
            '428071000124103' => 'Heavy tobacco smoker',
            '428061000124105' => 'Light tobacco smoker' }

     codeXpath = "/ClinicalDocument[1]/component[1]/structuredBody[1]/component[14]/section[1]/entry[1]/observation[1]/value[1]/@code"
     smoking = XPath.first(@xml_doc, codeXpath)
     #puts smoking

     smoking = smokingCodes["#{smoking}"] + "(#{smoking})"
     
     codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/patient[1]/birthTime[1]/@value"
     dob = XPath.first(@xml_doc, codeXpath)

     dob = DateTime.parse(dob.to_s)
     age = ((Date.today - dob).to_i / 365.25).ceil
     
     codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/patient[1]/administrativeGenderCode[1]/@displayName"
     gender = XPath.first(@xml_doc, codeXpath)
     
     codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/addr[1]/postalCode[1]/node()[1]"
     zipcode = XPath.first(@xml_doc, codeXpath)
     
    
    
    string = { 'smoking' => smoking,
            'age' => age,
            'gender' =>  gender,
            'zipcode' =>  zipcode }
    #string = '{"desc":{"someKey":"#{smoking}","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
    
    #puts {"payerpayload":{"smoking":"#{smoking}"}, {"age":"#{age}"}, {"gender":"#{gender}"}, {"zipcode":"#{zipcode}"}}
    puts string.to_json
    
  end
  
  def to_json
    puts @xml_json.to_json
    
  end
  
  def to_hash
    
    puts @xml_json_hash
    
  end
  
 
end