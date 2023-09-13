//
//  macOS_Widgit.swift
//  macOS Widgit
//
//  Created by Craig on 6/7/23.
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

struct macOS_WidgitEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(){
            Text("Shift Remaining:")
                .foregroundStyle(.purple)
            Text(entry.shift.timeString(), style: .timer)
                .font(.system(.title))
                .foregroundStyle(.cyan)
                .multilineTextAlignment(.center)
                .padding(.top, 1)
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}


struct macOS_Widgit: Widget {
    let kind: String = "macOS_Widgit"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            macOS_WidgitEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct macOS_Widgit_Previews: PreviewProvider {
    static let shift = Shift()
    static var previews: some View {
        macOS_WidgitEntryView(entry: SimpleEntry(date: Date(), shift: shift))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

#Preview(as: .systemSmall) {
    macOS_Widgit()
} timeline: {
    SimpleEntry(date: .now, shift: Shift())

}
