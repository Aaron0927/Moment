//
//  OnboardingPage.swift
//  Moment
//
//  Onboarding 页面数据模型
//

import Foundation

struct OnboardingPage: Identifiable, Equatable {
    let id: Int
    let title: String
    let description: String
    let buttonTitle: String

    static let pages: [OnboardingPage] = [
        OnboardingPage(
            id: 0,
            title: "多维度记录",
            description: "文字、语音、照片，用你喜欢的方式捕捉每一个生活瞬间。",
            buttonTitle: "继续"
        ),
        OnboardingPage(
            id: 1,
            title: "优雅时间轴",
            description: "让点滴记录汇成生命的长河，随时回溯那段美好时光。",
            buttonTitle: "继续探索"
        ),
        OnboardingPage(
            id: 2,
            title: "安全与私密",
            description: "你的回忆只有你能看到，我们采用端到端加密保护你的隐私。",
            buttonTitle: "开始使用"
        )
    ]
}