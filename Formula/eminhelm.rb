class Eminhelm < Formula
  # ...
  desc "Schema registry"
  homepage "https://github.com/vrahmanov"
  version "0.0.2"
  head "https://github.com/vrahmanov/dantidote.git", branch: "main" # the default is "master"
  on_macos do
      if Hardware::CPU.arm?
        url "https://gist.githubusercontent.com/vrahmanov/aa5ad4f44997ac5143b4d233fe8d7023/raw/f684cf6e20da7df4a9c6789283ba68e12b4b3533/helm_split.sh"
        def install
          puts "inside install"
          puts %x(whoami)
          installer_script = "helm_split.sh"
          bin.install installer_script
          system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
          bin.install_symlink "#{prefix}/bin/#{installer_script}" => "eminhelm"
        end
      end
    end
end