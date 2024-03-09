import SwiftUI

struct ContentView: View {
    @State var mark = "❌"
    @State var arrayButtons = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State var textWin = ""
    @State var checker = false
    var body: some View {
        VStack {
           Field(mark: $mark, arrayButtons: $arrayButtons, textWin: $textWin, checker: $checker)
                .frame(width: 330, height: 330)
            Text(textWin)
                .frame(height: 60)
                .font(.system(size: 60))
                .padding(.top, 70)
            Button(action: {
                arrayButtons = Array(repeating: Array(repeating: "", count: 3), count: 3)
                textWin = ""
                checker = false
            }) {
                Text("Clear")
                    .frame(width: 120, height: 50)
                    .font(.system(size: 30))
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 70)
        }
    }
}

struct Field : View {
    func checkWin(_ i: Int, _ j: Int, _ arrayBtn: [[String]], _ mark : String) -> String {
        if arrayBtn[i][0] == mark && arrayBtn[i][1] == mark && arrayBtn[i][2] == mark {
            return "\(mark) win!"
        }
        else if arrayBtn[0][j] == mark && arrayBtn[1][j] == mark && arrayBtn[2][j] == mark {
            return "\(mark) win!"
        }
        else if (arrayBtn[0][0] == mark && arrayBtn[1][1] == mark && arrayBtn[2][2] == mark) || (arrayBtn[0][2] == mark && arrayBtn[1][1] == mark && arrayBtn[2][0] == mark) {
            return "\(mark) win!"
        }
        else {
            return ""
        }
    }
    
    func resetField() {
        arrayButtons = Array(repeating: Array(repeating: "", count: 3), count: 3)
    }
    
    @Binding var mark : String
    @Binding var arrayButtons : [[String]]
    @Binding var textWin : String
    @Binding var checker : Bool
    var body: some View {
            VStack() {
                Spacer()
                HStack() {
                    Spacer()
                    ZStack() {
                        ZStack() {
                            HStack(spacing: 100) {
                                Rectangle()
                                    .frame(width: 10, height: 320)
                                    .cornerRadius(10)
                                Rectangle()
                                    .frame(width: 10, height: 330)
                                    .cornerRadius(10)
                            }
                            VStack(spacing: 100) {
                                Rectangle()
                                    .frame(width: 320, height: 10)
                                    .cornerRadius(10)
                                Rectangle()
                                    .frame(width: 320, height: 10)
                                    .cornerRadius(10)
                            }
                        }
                        VStack() {
                            ForEach(0..<3) {
                                i in
                                HStack() {
                                    ForEach(0..<3) {
                                        j in
                                        Button(action: {
                                            guard arrayButtons[i][j] != "" else {
                                                arrayButtons[i][j] = mark
                                                textWin = checkWin(i, j, arrayButtons, mark)
                                                mark = (mark == "❌") ? "⭕️" : "❌"
                                                if textWin != "" {
                                                checker = true
                                                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                                                        resetField()
                                                        textWin = ""
                                                    checker = false
                                                    }
                                                }
                                                return
                                            }

                                        }) {
                                            Text(arrayButtons[i][j])
                                                .frame(width: 110, height: 110)
                                                .font(.system(size: 60))
                                                .foregroundColor(.red)
                                        }
                                        .disabled(checker)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
