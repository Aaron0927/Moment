//
//  HomeView.swift
//  Moment
//
//  首页占位页面
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()

            VStack(spacing: Spacing.stackMedium) {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.themeSurfaceTint)

                Text("Home")
                    .font(.themeHeadlineLarge)
                    .foregroundStyle(Color.themeOnSurface)

                Text("欢迎回来！")
                    .font(.themeBodyMedium)
                    .foregroundStyle(Color.themeOnSurfaceVariant)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}