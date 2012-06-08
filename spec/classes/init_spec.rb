require "#{File.join(File.dirname(__FILE__),'..','spec_helper')}"

describe "install4j" do

  context "installs with a default configuration" do
    let(:params) {{
        :license => "THE_LICENSE",
        :run_as => "u",
    }}

    it { should contain_file("/home/u/.install4j4/config.xml").with_owner("u") }

    it { should contain_package("install4j").with_ensure("4.2.8") }

  end

  context "installs with a different version" do
    let(:params) {{
        :license => "THE_LICENSE",
        :run_as => "u",
        :version => "4.2.7",
    }}

    it { should contain_file("/home/u/.install4j4/config.xml").with_owner("u") }

    it { should contain_package("install4j").with_ensure("4.2.7") }

  end

end