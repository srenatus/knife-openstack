require 'spec_helper'
require 'chef/knife/openstack_flavor_list'
require 'chef/knife/cloud/openstack_service'
require 'support/shared_examples_for_command'

describe Chef::Knife::Cloud::OpenstackFlavorList do
  it_behaves_like Chef::Knife::Cloud::Command, Chef::Knife::Cloud::OpenstackFlavorList.new

  let (:instance) {Chef::Knife::Cloud::OpenstackFlavorList.new}

  context "#validate!" do
    before(:each) do
      Chef::Config[:knife][:openstack_username] = "testuser"
      Chef::Config[:knife][:openstack_password] = "testpassword"
      Chef::Config[:knife][:openstack_auth_url] = "tsturl"
      instance.stub(:exit)
    end

    it "validate openstack mandatory options" do
      expect {instance.validate!}.to_not raise_error
    end

    it "raise error on openstack_username missing" do
      Chef::Config[:knife].delete(:openstack_username)
      instance.ui.should_receive(:error).with("You did not provide a valid 'Openstack Username' value.")
      instance.validate!
    end

    it "raise error on openstack_password missing" do
      Chef::Config[:knife].delete(:openstack_password)
      instance.ui.should_receive(:error).with("You did not provide a valid 'Openstack Password' value.")
      instance.validate!
    end

    it "raise error on openstack_auth_url missing" do
      Chef::Config[:knife].delete(:openstack_auth_url)
      instance.ui.should_receive(:error).with("You did not provide a valid 'Openstack Auth Url' value.")
      instance.validate!
    end
  end


end