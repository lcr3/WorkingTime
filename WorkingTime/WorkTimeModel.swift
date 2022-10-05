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
    private var currentTime: Date
    private var timer: Timer?


    private let todayDate: Date
    private let dateFormatter: DateFormatter
    private var cancellable: AnyCancellable?

    public init() {
        self.todayDate = Date()
        self.dateFormatter = DateFormatter()
        self.currentTime = Date()
        self.dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MMMdHms",
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
        self.today = dateFormatter.string(from: todayDate)
        self.cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.currentTime = Date()
                self.today = self.dateFormatter.string(from: self.currentTime)
            }
    }

    func periodicalFunction() {
        print("update")
    }

    public func startButtonTapped() {
        print("start")
    }
    public func pauseButtonTapped() {
        print("pause")
    }
    public func endButtonTapped() {
        print("end")
    }
}
