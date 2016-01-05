
# chef push jobs requires full URLs
#
node.default['push_jobs']['package_url'] = "https://opscode-push-jobs-client-packages.s3.amazonaws.com/push-1.3-stable/windows/2008r2/x86_64/push-jobs-client-1.3.4-1.msi"
node.default['push_jobs']['package_checksum'] = "622f6fa1f1f9828ada9c3f44b82f4abb90522050d961d373d19990db4e6a124a"

node.default['push_jobs']['whitelist'] = {
  "chef-client" => "chef-client",
}
