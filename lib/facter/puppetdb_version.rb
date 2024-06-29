Facter.add(:puppetdb_version) do
  confine { Facter::Util::Resolution.which('puppetdb') }

  setcode do
    if Facter.value(:os)['family'] == 'Debian'
      output = Facter::Core::Execution.execute('puppetdb version')
      # example output:
      # version=8.4.1
      # target_schema_version=84
      output.split("\n").first.split('=').last
    else
      output = Facter::Core::Execution.execute('puppetdb --version')
      # example output:
      # puppetdb version: 7.18.0
      output.split(':').last.strip
    end
  end
end
