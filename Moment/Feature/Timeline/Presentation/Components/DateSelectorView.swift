//
//  DateSelectorView.swift
//  Moment
//
//  一周日期选择器组件 - 支持左右滑动
//

import SwiftUI

struct DateSelectorView: View {
    /// 当前选择的日期
    @Binding var selectedDate: Date

    /// 可选择的最新日期 (默认为今天)
    let maxDate: Date

    /// 日期被选中时的回调
    var onDateSelected: ((Date) -> Void)?

    @State private var offset: CGFloat = 0
    @State private var currentWeekOffset: Int = 0

    private let calendar = Calendar.current
    private let daySize: CGFloat = 32
    private let spacing: CGFloat = 46

    init(
        selectedDate: Binding<Date>,
        maxDate: Date = Date(),
        onDateSelected: ((Date) -> Void)? = nil
    ) {
        self._selectedDate = selectedDate
        self.maxDate = maxDate
        self.onDateSelected = onDateSelected
    }

    var body: some View {
        GeometryReader { geometry in
            let weekWidth = spacing * 7

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(weekDates, id: \.self) { date in
                        DateItemView(
                            date: date,
                            isSelected: isSameDay(date, selectedDate),
                            isToday: isSameDay(date, Date()),
                            isFuture: date > maxDate
                        )
                        .frame(width: daySize, height: 51)
                        .onTapGesture {
                            if date <= maxDate {
                                selectedDate = date
                                onDateSelected?(date)
                            }
                        }
                    }
                }
                .padding(.horizontal, (geometry.size.width - weekWidth) / 2)
            }
        }
        .frame(height: 70)
    }

    /// 获取当前周日期
    private var weekDates: [Date] {
        let today = calendar.startOfDay(for: Date())
        let weekday = calendar.component(.weekday, from: today)
        let daysFromMonday = (weekday + 5) % 7

        let monday = calendar.date(byAdding: .day, value: -daysFromMonday, to: today)!

        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: monday)
        }
    }

    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
}

// MARK: - 日期单项视图

private struct DateItemView: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let isFuture: Bool

    private let calendar = Calendar.current

    var body: some View {
        VStack(spacing: 4) {
            Text(weekdayLabel)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(weekdayColor)

            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.themePrimary)
                        .frame(width: 32, height: 32)
                }

                Text(dayLabel)
                    .font(.system(size: 16, weight: isSelected ? .bold : .medium))
                    .foregroundStyle(dayColor)
            }
            .frame(width: 32, height: 32)
        }
    }

    private var weekdayLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).uppercased()
    }

    private var dayLabel: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private var weekdayColor: Color {
        if isSelected {
            return Color.themePrimary
        }
        return Color.themeOnSurfaceVariant.opacity(0.6)
    }

    private var dayColor: Color {
        if isFuture {
            return Color.themeOnSurface.opacity(0.4)
        }
        if isSelected {
            return Color.themeOnPrimary
        }
        return Color.themeOnSurface
    }
}

#Preview {
    VStack {
        DateSelectorView(selectedDate: .constant(Date()))
        Spacer()
    }
    .padding()
}