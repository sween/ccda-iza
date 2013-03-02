require 'rexml/document'
require 'date'

include REXML

class Iza
  
  def initialize(xmlfile)
    xmldoc = Document.new(xmlfile)
    @xml_doc = xmldoc   
  end
  
  # SOCIAL STATUS
  
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


   puts smokingCodes["#{smoking}"] + "(#{smoking})"
    
  end
  
  # PATIENT
  
  def age
    
  
  codeXpath = "/ClinicalDocument[1]/recordTarget[1]/patientRole[1]/patient[1]/birthTime[1]/@value"
  dob = XPath.first(@xml_doc, codeXpath)
  
  dob = DateTime.parse(dob.to_s)
  age = ((Date.today - dob).to_i / 365.25).ceil
  #birthyear = Date.strptime age, '%m%d%Y'
  
  puts age
  
    
  end
  
 
end