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
//    @State var timeRemaining = timeString(lunchLength: "30", shiftLength: "8")
    
    var body: some View {
        VStack(){
            Text("Shift Remaining:")
            Text(Date.now.advanced(by: Double(timeString(lunchLength: entry.shift.lunchLength, shiftLength: entry.shift.workLength))), style: .timer)
                .font(.system(.title))
                .foregroundColor(.cyan)
                .multilineTextAlignment(.center)
                .padding(.top, 1)
            
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

func timeString(lunchLength: String, shiftLength: String) -> Int {
    
    let lunchTime = (Double(lunchLength) ?? 30) * 60
    let shiftTime = (Double(shiftLength) ?? 8) * 60 * 60
    let endTime = Calendar.current.date(from: DateComponents(hour: 8))!.advanced(by: lunchTime + shiftTime)
    
    let time = Calendar.current.dateComponents([.hour, .minute, .second], from: endTime)
    let today = Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)
    
    let hours   = (time.hour ?? 0) - (today.hour ?? 0)
    let minutes = (time.minute ?? 0) - (today.minute ?? 0)
    let seconds = (time.second ?? 0) - (today.second ?? 0)
    
    print((hours * 3600 + minutes * 60 + seconds))
    
    return (hours * 3600 + minutes * 60 + seconds)
    
}
