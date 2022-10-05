//
//  WorkTimeView.swift
//  WorkingTime
//
//  Created by lcr on 2022/10/05.
//

import SwiftUI

struct WorkTimeView: View {
    @ObservedObject var model: WorkTimeModel

    init() {
        model = WorkTimeModel()
    }

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "stopwatch")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(model.today)
            HStack {
                Button("👨‍💻") {
                    model.startButtonTapped()
                }
                Button("☕️") {
                    model.pauseButtonTapped()
                }
                Button("😪") {
                    model.endButtonTapped()
                }
            }
            List(model.timeline, id: \.self) { timeline in
                Text(timeline)
            }
        }
        .padding()
    }
}

struct WorkTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorkTimeView()
    }
}
