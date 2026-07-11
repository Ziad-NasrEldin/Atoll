import CoreGraphics
import Foundation

enum ExtensionNotchSizing {
    static let adaptiveBundleIdentifier = "com.ziadnasreldin.ZoidCoach"
    static let preferredWidthMetadataKey = "preferredWidth"
    static let preferredHeightMetadataKey = "preferredHeight"

    static func supportsExpandedSurface(bundleIdentifier: String) -> Bool {
        bundleIdentifier == adaptiveBundleIdentifier
    }

    static func requestedDimension(
        metadata: [String: String],
        key: String
    ) -> CGFloat? {
        guard let rawValue = metadata[key],
              let value = Double(rawValue),
              value.isFinite,
              value > 0 else {
            return nil
        }
        return CGFloat(value)
    }

    static func resolvedSize(
        baseSize: CGSize,
        requestedWidth: CGFloat?,
        requestedHeight: CGFloat?,
        maximumWidth: CGFloat,
        maximumHeight: CGFloat
    ) -> CGSize {
        let safeMaximumWidth = max(maximumWidth, baseSize.width)
        let safeMaximumHeight = max(maximumHeight, baseSize.height)
        let width = min(max(requestedWidth ?? baseSize.width, baseSize.width), safeMaximumWidth)
        let height = min(max(requestedHeight ?? baseSize.height, baseSize.height), safeMaximumHeight)
        return CGSize(width: width, height: height)
    }

    static func resolvedLegacyTabHeight(
        baseHeight: CGFloat,
        preferredHeight: CGFloat,
        maximumAdditionalHeight: CGFloat
    ) -> CGFloat {
        min(
            max(preferredHeight, baseHeight),
            baseHeight + maximumAdditionalHeight
        )
    }
}
