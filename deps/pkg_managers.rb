dep 'package manager', :cmd do
  met? {
    in_path?(cmd).tap {|result|
      unmeetable! "The package manager's binary, #{cmd}, isn't in the $PATH." unless result
    }
  }
end

dep 'apt' do
  requires 'package manager'.with('apt-get')
  requires {
    on :ubuntu, 'apt source'.with(:repo => 'main'), 'apt source'.with(:repo => 'universe')
  }
end

dep 'homebrew' do
  requires 'build tools'
  met? { in_path? 'brew' }
  meet { log_shell 'Installing Homebrew', 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' }
end

dep 'npm' do
  requires {
    on :osx, 'npm.src'
    otherwise 'npm.bin'
  }
end

dep 'npm.src' do
  requires 'nodejs.bin'
  met? { which 'npm' }
  meet {
    log_shell "Installing npm", "curl -L https://www.npmjs.org/install.sh | #{'sudo' unless which('node').p.writable_real?} sh"
  }
end

dep 'npm.bin' do
  provides 'npm >= 1.1'
end

dep 'pip' do
  requires {
    on :brew, 'python.bin' # homebrew installs pip along with python.
    otherwise 'pip.bin'
  }
end

dep 'pip.bin' do
  requires 'python.bin' # To ensure python-dev is pulled in.
  installs 'python-pip'
end
