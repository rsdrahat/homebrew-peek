cask "peek" do
  version "0.3.1"
  sha256 "50c6b093160237a4e890d0c736ded8146336f27fc9bc65b6ab74aa7c00125e67"

  url "https://github.com/rsdrahat/peek/releases/download/v#{version}/peek-v#{version}.zip"
  name "peek"
  desc "Light, native macOS markdown viewer"
  homepage "https://github.com/rsdrahat/peek"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "peek.app"
  # Point at the shim (not the raw binary) so argv[0] resolves back to
  # the .app via readlink and SwiftPM's Bundle.module can locate resources.
  binary "#{appdir}/peek.app/Contents/MacOS/peek-cli", target: "peek"

  zap trash: [
    "~/Library/Preferences/dev.peek.app.plist",
    "~/Library/Saved Application State/dev.peek.app.savedState",
  ]
end
