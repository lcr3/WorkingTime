//
//  File.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/05.
//

import Combine
import Foundation

class WorkTimeModel: ObservableObject {
    @Published var today: String
    @Published var timeline: [String]
    let id = UUID()

    private var currentTime: Date
    private let dateFormatter: DateFormatter
    private var cancellable: AnyCancellable?

    public init() {
        self.timeline = []
        self.dateFormatter = DateFormatter()
        self.currentTime = Date()
        self.dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMdHms",
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
        self.today = dateFormatter.string(from: currentTime)
        self.cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.currentTime = Date()
                self.today = self.dateFormatter.string(from: self.currentTime)
            }
    }

    public func startButtonTapped() {
        print("start")
        timeline.append("Start \(today)")
    }
    public func pauseButtonTapped() {
        print("pause")
    }
    public func endButtonTapped() {
        print("end")
        timeline.append("End \(today)")
    }
}
