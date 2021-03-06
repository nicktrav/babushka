dep 'python.bin' do
  installs {
    via :apt, 'python', 'python-dev'
    via :zypper, 'python', 'python-devel'
    otherwise 'python'
  }
  provides {
    via :brew, 'python', 'python-config', 'pip' # homebrew installs pip along with python.
    otherwise 'python', 'python-config'
  }
end
