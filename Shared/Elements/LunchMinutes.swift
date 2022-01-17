//
//  LunchMinutes.swift
//  Tempus (iOS)
//
//  Created by Craig on 1/13/22.
//

import SwiftUI

struct LunchMinutes: View {
    @EnvironmentObject var shift: Shift
    var body: some View {
        HStack{
            Text("How long was lunch?")
//            TestTextfield(text: $shift.lunchLength, keyType: UIKeyboardType.decimalPad)
//                        .frame(maxWidth: 40, minHeight: 0, maxHeight: 30)
//                        .font(.headline)
            TextField("30", text: $shift.lunchLength)
                .frame(width: 40)
                .padding(.leading)
                #if os(iOS)
                .keyboardType(.numbersAndPunctuation)
                .submitLabel(.done)
                #endif
                
            Text("minutes")
        }
        .font(.title3)
    }
}

struct LunchMinutes_Previews: PreviewProvider {
    static var shift = Shift()
    static var previews: some View {
        LunchMinutes().environmentObject(shift)
    }
}

//#if os(iOS)
//struct TestTextfield: UIViewRepresentable {
//    @Binding var text: String
//    var keyType: UIKeyboardType
//    func makeUIView(context: Context) -> UITextField {
//        let textfield = UITextField()
//        textfield.font = UIFont.systemFont(ofSize: 20)
////        print(UIFont.familyNames)
//        textfield.placeholder = "30"
//      textfield.keyboardType = keyType
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
//        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
//        toolBar.items = [doneButton]
//        toolBar.setItems([doneButton], animated: true)
//        textfield.inputAccessoryView = toolBar
//        return textfield
//    }
//
//    func updateUIView(_ uiView: UITextField, context: Context) {
//        uiView.text = text
//
//    }
//}
//
//extension  UITextField{
//    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
//       self.resignFirstResponder()
//    }
//
//}
//#endif
