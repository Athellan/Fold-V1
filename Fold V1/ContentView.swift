import SwiftUI
import Foundation

struct ContentView: View {
        
    @State private var username = ""
    @State private var password = ""
    @State private var shouldNavigate = false

        func handleButtonPress() {
            let url = URL(string: "https://foldlab.io:8081/api/loginScanAccount")!

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                       
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self, from: data)

                        let user = response.datas.user
                        
                        var request = URLRequest(url: url)
                            request.httpMethod = "POST"

                        let username = user.username
                        let password = user.password

                        if username == self.username && password == self.password {
                           
                            DispatchQueue.main.async {
                                let qrScanView = QRscan()
                                NavigationLink(destination: qrScanView) {
                                    EmptyView()
                                }
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }

        var body: some View {
        NavigationView {
            ZStack {
                Color("primaryColor").ignoresSafeArea()
                VStack {
                    HStack(alignment: .top) {
                        Text("FOLD")
                            .font(.system(size: 50))
                            .foregroundColor(Color(.white))
                            .padding(.bottom, 80)
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: 345, height: 400)
                            .cornerRadius(25)
                            .foregroundColor(Color("secondaryColor"))
                            .shadow(radius: 10, x: 10, y: 3)
                        
                        VStack(alignment: .leading) {
                            Text("Se connecter")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .bold()
                                .padding(.bottom,50)
                            
                            
                            VStack(alignment: .leading) {
                                Text("Email")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.white)
                                HStack {
                                    TextField("Enter email", text: $username)
                                        .padding()
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("primaryColor"))
                                        .frame(width: 270, height: 50)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(width: 270, height: 60)
                            .padding(.bottom, 30)
                            
                            VStack(alignment: .leading) {
                                Text("Password")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.white)
                                HStack {
                                    TextField("Password", text: $password)
                                        .padding()
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("primaryColor"))
                                        .frame(width: 270, height: 50)
                                        .background(.white)
                                        .cornerRadius(10)
                                }
                            }
                            .frame(width: 270, height: 60)
                            .padding(.bottom, 50)
                            
                            
                            
                            
                            NavigationLink(destination: QRscan(), isActive: $shouldNavigate) {
                              Text("Login")
                            }
                          }
                            .foregroundColor(.white)
                            .frame(width: 270,height: 40)
                            .background(Color("buttonColor"))
                            .cornerRadius(10)
                            .onTapGesture {
                                handleButtonPress()
                                shouldNavigate.toggle()
                            }
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

