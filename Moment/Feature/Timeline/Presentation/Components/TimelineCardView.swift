//
//  TimelineCardView.swift
//  Moment
//
//  时间线条目卡片视图
//

import SwiftUI

struct TimelineCardView: View {
    let entry: TimelineEntry

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.gutter) {
            if entry.hasThumbnail {
                thumbnailView
            }

            contentView
        }
        .padding(Spacing.gutter)
        .background(
            RoundedRectangle(cornerRadius: RoundedCorner.large)
                .fill(Color.themeSurface)
                .shadow(
                    color: Color.themeOnSurface.opacity(0.05),
                    radius: 1,
                    x: 0,
                    y: 1
                )
        )
    }

    @ViewBuilder
    private var thumbnailView: some View {
        if let thumbnailName = entry.thumbnailName {
            RoundedRectangle(cornerRadius: RoundedCorner.medium)
                .fill(Color.themeSurfaceVariant)
                .frame(width: 64, height: 64)
                .overlay {
                    Image(systemName: thumbnailName)
                        .font(.system(size: 24))
                        .foregroundStyle(Color.themeOnSurfaceVariant)
                }
        }
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.themeOnSurface)
                .lineLimit(1)

            Text(entry.content)
                .font(.system(size: 13))
                .foregroundStyle(Color.themeOnSurfaceVariant)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - 时间线节点

struct TimelineNodeView: View {
    let isHighlighted: Bool

    var body: some View {
        Circle()
            .fill(isHighlighted ? Color.themePrimary : Color.themeSurface)
            .frame(width: 16, height: 16)
            .overlay {
                Circle()
                    .stroke(isHighlighted ? Color.themeTertiary : Color.themeOutline, lineWidth: 2)
            }
    }
}

#Preview {
    VStack(spacing: 20) {
        TimelineCardView(entry: TimelineEntry.sampleEntries[0])
        TimelineCardView(entry: TimelineEntry.sampleEntries[1])
    }
    .padding()
}