require 'spec_helper'

describe 'apt-nginx' do
  describe 'when on ubuntu 12.04' do
    describe 'by default' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
          .converge(described_recipe)
      end

      it 'should add the nginx-stable repo with default attribs' do
        expect(chef_run).to add_apt_repository('nginx-stable').with(
          uri: 'http://nginx.org/packages/ubuntu/',
          distribution: 'precise',
          components: ['nginx'],
          key: 'nginx_signing.key',
          deb_src: false
        )
      end

      it 'should not add the nginx-mainline repo' do
        expect(chef_run).to_not add_apt_repository('nginx-mainline')
      end
    end

    describe 'when nginx-stable is not managed and nginx-mainline is managed' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
          node.set['apt-nginx']['repos']['nginx-stable']['managed'] = false
          node.set['apt-nginx']['repos']['nginx-mainline']['managed'] = true
        end.converge(described_recipe)
      end

      it 'should not add the nginx-stable repo' do
        expect(chef_run).to_not add_apt_repository('nginx-stable')
      end

      it 'should add the nginx-mainline repo with default attribs' do
        expect(chef_run).to add_apt_repository('nginx-mainline').with(
          uri: 'http://nginx.org/packages/mainline/ubuntu/',
          distribution: 'precise',
          components: ['nginx'],
          key: 'nginx_signing.key',
          deb_src: false
        )
      end
    end

    describe 'when adding a custom nginx repo' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
          node.set['apt-nginx']['repos']['nginx-new']['managed'] = true
          node.set['apt-nginx']['repos']['nginx-new']['uri'] = 'http://path.to.nginx'
          node.set['apt-nginx']['repos']['nginx-new']['components'] = ['nginx']
          node.set['apt-nginx']['repos']['nginx-new']['distribution'] = 'precise'
          node.set['apt-nginx']['repos']['nginx-new']['key'] = 'file://path/to/gpg/key'
          node.set['apt-nginx']['repos']['nginx-new']['deb-src'] = false
        end.converge(described_recipe)
      end

      it 'should add the nginx-new repo' do
        expect(chef_run).to add_apt_repository('nginx-new').with(
          uri: 'http://path.to.nginx',
          distribution: 'precise',
          components: ['nginx'],
          key: 'file://path/to/gpg/key',
          deb_src: false
        )
      end
    end
  end

  supported_platforms = {
    debian: ['6.0.5', '7.0', '8.0'],
    ubuntu: ['10.04', '12.04', '14.04', '14.10']
  }

  supported_platforms.each do |platform, versions|
    versions.each do |version|
      describe "when on #{platform} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: platform.to_s, version: version)
            .converge(described_recipe)
        end

        it 'should not raise an error' do
          expect { chef_run }.to_not raise_error
        end
      end
    end
  end

  describe 'when on an unsupported platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '13.04')
        .converge(described_recipe)
    end

    it 'should raise an error' do
      expect { chef_run }.to \
        raise_error('debian/ubuntu/13.04 is not supported by the default recipe')
    end
  end
end
