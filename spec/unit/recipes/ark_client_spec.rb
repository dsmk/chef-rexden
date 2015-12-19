#
# Cookbook Name:: rexden
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rexden::ark_client' do
  context 'on Red Hat 7.0' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'redhat',
        version: 7.0
      )
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'ensures that the root .ssh directory exists' do
      expect( chef_run ).to create_directory('/root/.ssh').with(
        user: 'root',
        group: 'root',
        mode: '0700'
      )
    end

    it 'ensure that the push backup ssh key has been installed' do
      expect( chef_run ).to create_cookbook_file('/root/.ssh/push-backup').with(
        user: 'root',
        group: 'root',
        mode: '0700'
      )
    end

    it 'ensure that ark script installed' do
      expect( chef_run ).to create_cookbook_file('/usr/sbin/ark').with(
        user: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'the ark configuration directory exists' do
      expect( chef_run ).to create_directory('/etc/ark.d').with(
        user: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'common ark configuration for all servers' do
      expect( chef_run ).to create_cookbook_file('/etc/ark.d/core.s').with(
        user: "root",
        group: "root",
        mode: "0700"
      )
    end

    it 'ensure ark cron job exists' do
      expect( chef_run ).to create_cookbook_file('/etc/cron.d/ark-cron').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'ensure rsync package is installed' do
      expect( chef_run ).to install_package('rsync')
    end

  end

  context 'on Ubuntu 14.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(
        platform: 'ubuntu',
        version: 14.04
      )
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'ensures that the root .ssh directory exists' do
      expect( chef_run ).to create_directory('/root/.ssh').with(
        user: 'root',
        group: 'root',
        mode: '0700'
      )
    end

    it 'ensure that the push backup ssh key has been installed' do
      expect( chef_run ).to create_cookbook_file('/root/.ssh/push-backup').with(
        user: 'root',
        group: 'root',
        mode: '0700'
      )
    end

    it 'ensure that ark script installed' do
      expect( chef_run ).to create_cookbook_file('/usr/sbin/ark').with(
        user: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'the ark configuration directory exists' do
      expect( chef_run ).to create_directory('/etc/ark.d').with(
        user: 'root',
        group: 'root',
        mode: '0755'
      )
    end

    it 'common ark configuration for all servers' do
      expect( chef_run ).to create_cookbook_file('/etc/ark.d/core.s').with(
        user: "root",
        group: "root",
        mode: "0700"
      )
    end

    it 'ensure ark cron job exists' do
      expect( chef_run ).to create_cookbook_file('/etc/cron.d/ark-cron').with(
        user: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'ensure rsync package is installed' do
      expect( chef_run ).to install_package('rsync')
    end

  end
end
