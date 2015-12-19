#
# Cookbook Name:: rexden
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'rexden::ark_server' do
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

    it 'ensures that the push backup user exists' do
      expect( chef_run ).to create_user('backup')
    end

    it 'ensure that the push backup ssh directory exists' do
      expect( chef_run ).to create_directory('/home/backup/.ssh').with(
        user: 'backup',
        group: 'backup',
        mode: '0700'
      )
    end

    it 'ensure that backup user authorized keys exists' do
      expect( chef_run ).to create_cookbook_file('/home/backup/.ssh/authorized_keys').with(
        user: 'backup',
        group: 'backup',
        mode: '0700'
      )
    end

    it 'ensure that the do-push-rsync.sh script exists' do
      expect( chef_run ).to create_cookbook_file('/home/backup/do-push-rsync.sh').with(
        user: 'backup',
        group: 'backup',
        mode: '0755'
      )
    end

    it 'ensure that clients file exists' do
      expect( chef_run ).to create_template('/home/backup/clients').with(
        user: "backup",
        group: "backup",
        mode: "0755"
      )
    end

    it 'ensure ark rsync.conf template installed' do
      expect( chef_run ).to create_cookbook_file('/etc/push-rsync.conf.template').with(
        user: 'root',
        group: 'root',
        mode: '0444'
      )
    end

    it 'ensure rsync cache directory exists' do
      expect( chef_run ).to create_directory('/var/cache/push-rsync').with(
        user: 'root',
        group: 'root',
        mode: 0750
      )
    end

    it 'ensure rsync package is installed' do
      expect( chef_run ).to install_package('rsync')
    end

  end

end
