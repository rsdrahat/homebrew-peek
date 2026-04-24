cask "peek" do
  version "0.3.5"
  sha256 "599cde1d0e59f9ba6bb3501f8fa2ed918ad747cf0b61126d1bd5c1660cd148d7"

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
