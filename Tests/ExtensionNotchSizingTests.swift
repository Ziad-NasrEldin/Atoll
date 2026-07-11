import CoreGraphics
import Foundation

@main
struct ExtensionNotchSizingTests {
    static func main() {
        precondition(
            ExtensionNotchSizing.supportsExpandedSurface(
                bundleIdentifier: "com.ziadnasreldin.ZoidCoach"
            )
        )
        precondition(
            !ExtensionNotchSizing.supportsExpandedSurface(
                bundleIdentifier: "com.example.UnrelatedExtension"
            )
        )
        precondition(ExtensionNotchSizing.requestedDimension(metadata: [:], key: "preferredWidth") == nil)
        precondition(ExtensionNotchSizing.requestedDimension(metadata: ["preferredWidth": "invalid"], key: "preferredWidth") == nil)
        precondition(ExtensionNotchSizing.requestedDimension(metadata: ["preferredWidth": "nan"], key: "preferredWidth") == nil)
        precondition(ExtensionNotchSizing.requestedDimension(metadata: ["preferredWidth": "0"], key: "preferredWidth") == nil)
        precondition(ExtensionNotchSizing.requestedDimension(metadata: ["preferredWidth": "1400"], key: "preferredWidth") == 1400)

        let base = CGSize(width: 640, height: 200)
        precondition(
            ExtensionNotchSizing.resolvedSize(
                baseSize: base,
                requestedWidth: 1400,
                requestedHeight: 650,
                maximumWidth: 1200,
                maximumHeight: 600
            ) == CGSize(width: 1200, height: 600)
        )
        precondition(
            ExtensionNotchSizing.resolvedSize(
                baseSize: base,
                requestedWidth: 320,
                requestedHeight: 100,
                maximumWidth: 1200,
                maximumHeight: 600
            ) == base
        )
        precondition(
            ExtensionNotchSizing.resolvedSize(
                baseSize: base,
                requestedWidth: 1400,
                requestedHeight: 650,
                maximumWidth: 500,
                maximumHeight: 150
            ) == base
        )
        precondition(
            ExtensionNotchSizing.resolvedLegacyTabHeight(
                baseHeight: base.height,
                preferredHeight: 100,
                maximumAdditionalHeight: 150
            ) == base.height
        )
        precondition(
            ExtensionNotchSizing.resolvedLegacyTabHeight(
                baseHeight: base.height,
                preferredHeight: 275,
                maximumAdditionalHeight: 150
            ) == 275
        )
        precondition(
            ExtensionNotchSizing.resolvedLegacyTabHeight(
                baseHeight: base.height,
                preferredHeight: 500,
                maximumAdditionalHeight: 150
            ) == 350
        )

        print("ExtensionNotchSizingTests passed")
    }
}
