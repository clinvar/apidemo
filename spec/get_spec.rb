# specs for HTTP GET
# @Author Xin Feng
# @Date 05/01/2014
# @Email xinf@bcm.edu


require 'rest'
require 'auth'
require 'urlb'

describe 'ClinGenDB RESTful API' do
  let(:stringUrl) {
    getUrl('documentID.dbsnpId','rs12345') 
  }

  let(:onekg){
    'documentID.evidence.'+
    'PopulationStudyEvidence.variantFrequency.'+
    '1000GenomesVariantFrequency'
  }

  let(:expectedFreq) {0.17}

  let(:floatUrl) {
    getUrl(onekg, expectedFreq)
  }

  let(:startlocus){
    'documentID.location.startOfGenomicLocus'
  }

  let(:expectedStartLocus) {48023115}

  let(:startUrl) {
    getUrl(startlocus, expectedStartLocus)
  }

  it 'should GET a string field' do
    expect {get(stringUrl)}.not_to raise_exception 
  end

  it 'should GET a float field' do
    expect {get(floatUrl)}.not_to raise_exception
  end

  it 'should GET the correct 1kg freq' do
    d=JSON.parse(get(floatUrl).body)
    val=d["data"].first
    freq=val["documentID"]["properties"]["evidence"]["properties"]["PopulationStudyEvidence"]["properties"]["variantFrequency"]["properties"]["1000GenomesVariantFrequency"]["value"]
    freq.should eq expectedFreq
  end

  it 'should GET the correct start of locus' do
    d=JSON.parse(get(startUrl).body)
    val=d["data"].first
    start=val["documentID"]["properties"]["location"]["properties"]["startOfGenomicLocus"]["value"]
    start.should eq expectedStartLocus
  end

end


