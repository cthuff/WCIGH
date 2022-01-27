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
    
    var body: some View {
        VStack(){
            Text("Shift Remaining:")
            Text(entry.shift.timeString(), style: .timer)
                .font(.system(.title))
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding(.top, 1)
        }
    }
}

@main
struct Widgit: Widget {
    let kind: String = "Widget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgitEntryView(entry: entry)
        }
        .configurationDisplayName("Clockout Widget")
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
