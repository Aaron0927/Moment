# Moment

## 项目简介
一个轻量记录生活片段，回放历史记录的iOS应用

## 技术栈
- **语言**: Swift 5.9
- **UI Framework**: SwiftUI
- **架构**: Clean Architecture + MVVM
- **依赖管理**: Swift Package Manager
- **Minimum**: iOS 17.0
- **Linting**: SwiftLint

## 常用命令

- Build: `xcodebuild -project Moment.xcodeproj -scheme Moment -configuration Debug -destination 'generic/platform=iOS'`
- Test: `xcodebuild  test -project Moment.xcodeproj -scheme Moment -destination 'platform=iOS Simulator,name=iPhone 17 Pro'`
- Clean: `xcodebuild clean -project Moment.xcodeproj -scheme Moment`


## 架构
四层严格划分.依赖关系只能自下而上(依赖规则): UI -> Presentation -> Domain <- Data.
```
UI Layer -> Presentation Layer -> Domain Layer <- Data Layer
```
基础层代码放在 `Foundation/`

## 注意事项
- 优先使用 async/await
- 内容不要全部写在一个文件中，每个功能模块按照 Data / Domain / Presentation 结构划分