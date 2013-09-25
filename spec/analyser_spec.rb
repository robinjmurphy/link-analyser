require 'analyser'

describe Analyser do
    describe ".analyse" do

        before do
            @links = Analyser.analyse html
        end

        let :html do
         '<a href="http://www.absolute.com/">My absolute link</a>
          <a href="/relative">My relative link</a>
          <a href="https://www.secure.com/">Secure link</a>
          <a href="//www.protocolfree.com/">Protocol-less link</a>
          <a href="/example.com/link">Relative link with periods</a>
          <a name="my_anchor"/>'
        end

        it "should return the absolute links in a HTML string" do
            absolute_links = @links[:absolute]
            absolute_links.length.should == 3
            absolute_links[0][:href].should == "http://www.absolute.com/"
            absolute_links[0][:text].should == "My absolute link"
            absolute_links[1][:href].should == "https://www.secure.com/"
            absolute_links[1][:text].should == "Secure link"
            absolute_links[2][:href].should == "//www.protocolfree.com/"
            absolute_links[2][:text].should == "Protocol-less link"
        end

        it "should return the relative links in a HTML string" do
            relative_links = @links[:relative]
            relative_links.length.should == 2
            relative_links[0][:href].should == "/relative"
            relative_links[0][:text].should == "My relative link"
            relative_links[1][:text].should == "Relative link with periods"
            relative_links[1][:href].should == "/example.com/link"
        end

    end
end