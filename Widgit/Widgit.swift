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
            Text(timeString(shift: entry.shift), style: .timer)
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

//Does the math that is contained in shift.ClockOut and shift.Remaining, but uses local variables to allow for updaing when the data changes
func timeString(shift: Shift) -> Date {
    let lunchTime = (Double(shift.lunchLength) ?? 30) * 60
    let shiftTime = (Double(shift.workLength) ?? 8) * 3600
    let endTime = Calendar.current.date(from: DateComponents(hour: 0, minute: 0, second: 0))!.advanced(by: lunchTime + shiftTime + Double(shift.startTime))
    
    let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
    let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)

    let hours   = (time.hour ?? 0) - (today.hour ?? 0)
    let minutes = (time.minute ?? 0) - (today.minute ?? 0)
    let seconds = (time.second ?? 0) - (today.second ?? 0)

    let tempTime = (hours * 3600 + minutes * 60 + seconds)
    
    return Date().advanced(by: Double(tempTime))
}
