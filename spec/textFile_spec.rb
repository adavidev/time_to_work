require_relative '../textFile'


describe "Test text import" do

  it "should have the read method" do
    @textFile = TextFile.new("spec_r.txt")
    @textFile.should respond_to("read")
  end

  it "should have the read method" do
    @textFile = TextFile.new("spec_r.txt")
    @textFile.should respond_to("write")
  end

  it "should parse text correctly" do
    @textFile = TextFile.new("spec_r.txt")
    @textFile.read().should eql [{"text"=>"WORDS and words", "projects"=>["+class", "+project"], "context"=>["@home", "@work"], "due"=>"11/11/2015"}]
  end

  it "should write text correctly" do
    @textFile = TextFile.new("spec_w.txt")
    data = [{"text"=>"WORDS", "projects"=>["+project"], "context"=>["@work"], "due"=>"11/11/2015"},
            {"text"=>"and words", "projects"=>["+class"], "context"=>["@home"], "due"=>"1/1/2017"}]
    @textFile.write(data)
    expect( File.size("spec_w.txt") ).to be == 72
  end

end