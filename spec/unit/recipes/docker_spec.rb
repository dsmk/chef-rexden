#
# Cookbook Name:: rexden
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rexden::docker_redhat' do
  context 'on Red Hat 7.0' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'redhat',
        version: 7.0
      )
      runner.converge("rexden::docker")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs docker' do
      expect( chef_run ).to install_package('docker')
    end

    it 'starts docker service' do
      expect( chef_run ).to start_service('docker')
    end

    it 'enable docker service' do
      expect( chef_run ).to enable_service('docker')
    end

    it 'does docker sysconfig' do
      expect( chef_run ).to create_template('/etc/sysconfig/docker').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end
  end

  context 'on Ubuntu 14.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: 14.04
      )
      runner.converge("rexden::docker")
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs docker' do
      expect( chef_run ).to install_package('docker')
    end

    it 'starts docker service' do
      expect( chef_run ).to start_service('docker')
    end

    it 'enable docker service' do
      expect( chef_run ).to enable_service('docker')
    end

    it 'does docker sysconfig' do
      expect( chef_run ).to create_template('/etc/sysconfig/docker').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end
  end
end
