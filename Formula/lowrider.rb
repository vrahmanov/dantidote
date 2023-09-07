class Lowrider < Formula
    # ...
    desc "Schema registry"
    homepage "https://github.com/vrahmanov"
    version "0.0.1"
    on_macos do
        if Hardware::CPU.arm?
          url "https://raw.githubusercontent.com/vrahmanov/dantidote/main/helm.sh"
          def install
            puts "inside install"
            puts %x(whoami)
            installer_script = "helm.sh"
            bin.install installer_script
            # exec("#{prefix}/bin/#{installer_script}")
            system "chmod", "+x", "#{prefix}/bin/#{installer_script}"
            # system "alias", "lowrider" ,"=", "#{prefix}/bin/#{installer_script}"
            bin.install_symlink /opt/homebrew/Cellar/lowrider/0.0.1/bin/helm.sh/"lowrider"
            # alias lowrider="/opt/homebrew/Cellar/lowrider/0.0.1/bin/helm.sh"
                        # # Move everything under #{libexec}/
                        # libexec.install Dir["*"]
                        # # Then write executables under #{bin}/
                        # bin.write_exec_script (libexec/"test.sh")
          end
        end
      end
end