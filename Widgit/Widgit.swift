//
//  Widgit.swift
//  Widgit
//
//  Created by Craig on 1/19/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    var shift = Shift()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), shift: shift)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), shift: shift)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), shift: shift)]


        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    var shift: Shift
}

struct WidgitEntryView : View {
    var entry: Provider.Entry
    @State var timeRemaining = 3600
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack{
            Text("Time Remaining:")
            
        }
    }
}

@main
struct Widgit: Widget {
    let kind: String = "Widgit"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgitEntryView(entry: entry)
        }
        .configurationDisplayName("Clockout Widgit")
        .description("Keep an eye on when you can clock out")
    }
}

struct Widgit_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        WidgitEntryView(entry: SimpleEntry(date: Date(), shift: shift))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

func timeString(_ time: Int) -> String {
    let hours   = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    
}
