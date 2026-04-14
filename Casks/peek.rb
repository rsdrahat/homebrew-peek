cask "peek" do
  version "0.3.0"
  sha256 "a1b91be75d2d4a1fd1a9b8914edad172754463e1669bc6dcfd3f95d4df46ebd4"

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
  binary "#{appdir}/peek.app/Contents/MacOS/peek"

  zap trash: [
    "~/Library/Preferences/dev.peek.app.plist",
    "~/Library/Saved Application State/dev.peek.app.savedState",
  ]
end
