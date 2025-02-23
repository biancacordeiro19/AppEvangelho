import SwiftUI
import Firebase
import FirebaseAuth

@main
struct EvangelhodoDiaApp: App {
   @StateObject private var authViewModel = AuthViewModel() // ViewModel de Autenticação

   init() {
       FirebaseApp.configure() // Inicializa o Firebase
   }

   var body: some Scene {
       WindowGroup {
           if authViewModel.isAuthenticated {
               Tela01()
                   .environmentObject(authViewModel) // Passando para a Tela01
           } else {
               EntrarView()
                   .environmentObject(authViewModel) // Passando para a tela de login
           }
       }
   }
}

// 🔹 ViewModel para Gerenciar Autenticação
class AuthViewModel: ObservableObject {
   @Published var isAuthenticated = false
   @Published var errorMessage: String?

   func login(email: String, password: String) {
       Auth.auth().signIn(withEmail: email, password: password) { result, error in
           DispatchQueue.main.async {
               if let error = error {
                   self.errorMessage = error.localizedDescription
                   self.isAuthenticated = false
               } else {
                   self.isAuthenticated = true
                   self.errorMessage = nil
               }
           }
       }
   }

   func logout() {
       try? Auth.auth().signOut()
       DispatchQueue.main.async {
           self.isAuthenticated = false
       }
   }
}

struct Tela01: View {
   var body: some View {
       NavigationSplitView {
           sidebar()
       } detail: {
           sidebar()
       }
   }
}

struct Sidebar: View {
    var body: some View {
        VStack {
            Text("Bem-vindo!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text("Fortaleça sua fé e encontre esperança em cada passo com Cristo.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                NavigationLink(destination: EvangelhoView()) {
                    OptionCard(title: "Evangelho do Dia", color: .blue, iconName: "book")
                }
                
                NavigationLink(destination: QuestionView()) {
                    OptionCard(title: "Perguntas", color: .green, iconName: "questionmark.circle")
                }
                
                NavigationLink(destination: ConfiguracoesView()) {
                    OptionCard(title: "Configurações", color: .yellow, iconName: "gear")
                }
                
                NavigationLink(destination: EntrarView()) {
                    OptionCard(title: "Sair", color: .red, iconName: "arrow.right.square")
                }
            }
            Spacer()
        }
        .padding()
        
        // Menu Lateral

        }
    }
struct OptionCard: View {
   var title: String
   var color: Color
   var iconName: String

   var body: some View {
       VStack {
           Image(systemName: iconName)
               .font(.largeTitle)
               .foregroundColor(.white)

           Text(title)
               .font(.headline)
               .foregroundColor(.white)
       }
       .frame(width: 150, height: 100)
       .background(color)
       .cornerRadius(12)
       .shadow(radius: 4)
   }
}



struct Content: View {
   var body: some View {
       Text("Bem-vindo ao Evangelho!")
           .font(.largeTitle)
           .padding()
   }
}


struct ConfiguracoesView: View {
   var body: some View {
       VStack(spacing: 20) {
           Text("Configurações")
               .font(.largeTitle)
               .padding(.bottom, 20)

           TextField("Nome", text: .constant(""))
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)

           TextField("Email", text: .constant(""))
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)

           TextField("Idade", text: .constant(""))
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)

           SecureField("Nova Senha", text: .constant(""))
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)

           Button(action: {
               // Ação para salvar alterações
           }) {
               Text("Salvar Alterações")
                   .fontWeight(.bold)
                   .frame(maxWidth: .infinity)
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.blue)
                   .cornerRadius(8)
           }

           Spacer()
       }
       .padding()
   }
}


struct QuestionView: View {
   @State private var userAnswer: String = ""
   @State private var submittedAnswer: String? = nil

   var body: some View {
       VStack(spacing: 20) {
           Text("Como viver o Evangelho?")
               .font(.largeTitle)
               .fontWeight(.bold)
               .foregroundColor(Color.brown)
               .multilineTextAlignment(.center)
               .padding()

           TextEditor(text: $userAnswer)
               .padding()
               .frame(height: 150)
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)
               .overlay(
                   RoundedRectangle(cornerRadius: 8)
                       .stroke(Color.brown, lineWidth: 1)
               )
               .autocapitalization(.sentences)

           Button(action: submitAnswer) {
               Text("Enviar Resposta")
                   .fontWeight(.bold)
                   .frame(maxWidth: .infinity)
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.brown)
                   .cornerRadius(8)
           }

           if let answer = submittedAnswer {
               Text("Sua Resposta:")
                   .font(.headline)
                   .foregroundColor(.brown)
                   .padding(.top)

               Text(answer)
                   .font(.body)
                   .foregroundColor(.black)
                   .multilineTextAlignment(.leading)
                   .padding()
                   .background(Color.gray.opacity(0.1))
                   .cornerRadius(8)
           }

           Spacer()
       }
                   .padding()
                   .navigationBarTitle("Perguntas", displayMode: .inline)
                   .background(Color.white) // Fundo branco
               }

   private func submitAnswer() {
       if userAnswer.isEmpty {
           submittedAnswer = "Por favor, insira uma resposta antes de enviar."
       } else {
           submittedAnswer = userAnswer
           userAnswer = ""
       }
   }
}

struct Login: View {
   @State private var username: String = ""
   @State private var password: String = ""
   @State private var showError: Bool = false
   @State private var isLoggedIn: Bool = false

   var body: some View {
       VStack(spacing: 20) {
           Text("Bem-vindo!")
               .font(.largeTitle)
               .fontWeight(.bold)
               .padding(.bottom, 20)

           TextField("Usuário", text: $username)
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)
               .autocapitalization(.none)

           SecureField("Senha", text: $password)
               .padding()
               .background(Color.gray.opacity(0.2))
               .cornerRadius(8)

           Button(action: handleLogin) {
               Text("Entrar")
                   .fontWeight(.bold)
                   .frame(maxWidth: .infinity)
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.blue)
                   .cornerRadius(8)
           }

           if showError {
               Text("Usuário ou senha inválidos")
                   .foregroundColor(.red)
                   .font(.footnote)
           }

           Spacer()
       }
       .padding()
   }

   private func handleLogin() {
       if username.isEmpty || password.isEmpty {
           showError = true
       } else {
           showError = false
           isLoggedIn = true
       }
   }
}
// 🔹 Tela de Login (Corrigida)
struct EntrarView: View {
   @State private var email = ""
   @State private var password = ""
   @EnvironmentObject var authViewModel: AuthViewModel

   var body: some View {
       NavigationView {
           VStack(spacing: 20) {
               Text("Login")
                   .font(.largeTitle)
                   .underline()
               
               TextField("E-mail", text: $email)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()
                   .keyboardType(.emailAddress)
                   .autocapitalization(.none)

               SecureField("Senha", text: $password)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

               if let error = authViewModel.errorMessage {
                   Text(error)
                       .foregroundColor(.red)
                       .padding()
               }

               Button(action: {
                   authViewModel.login(email: email, password: password)
               }) {
                   Text("Entrar")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .foregroundColor(.white)
                       .background(Color.blue)
                       .cornerRadius(8)
               }
               .padding()

               NavigationLink(destination: CriarContaView()) {
                   Text("Criar uma conta")
                       .foregroundColor(.blue)
                       .underline()
               }

               Spacer()
           }
           .padding()
       }
   }
}

// 🔹 Tela de Criar Conta (Corrigida)
struct CriarContaView: View {
   @State private var name = ""
   @State private var email = ""
   @State private var password = ""
   @State private var confirmPassword = ""
   @State private var birthDate = Date()
   @State private var errorMessage: String?

   var body: some View {
       VStack(spacing: 20) {
           Text("Criar Conta")
               .font(.largeTitle)
               .fontWeight(.bold)

           TextField("Nome completo", text: $name)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()

           TextField("E-mail", text: $email)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .keyboardType(.emailAddress)
               .autocapitalization(.none)
               .padding()

           SecureField("Senha", text: $password)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()

           SecureField("Confirmar senha", text: $confirmPassword)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()

           DatePicker("Data de Nascimento", selection: $birthDate, displayedComponents: .date)
               .padding()

           if let error = errorMessage {
               Text(error)
                   .foregroundColor(.red)
                   .multilineTextAlignment(.center)
           }

           Button(action: createAccount) {
               Text("Criar Conta")
                   .fontWeight(.bold)
                   .frame(maxWidth: .infinity)
                   .padding()
                   .foregroundColor(.white)
                   .background(Color.blue)
                   .cornerRadius(8)
           }

           Spacer()
       }
       .padding()
   }

   private func createAccount() {
       guard !name.isEmpty else {
           errorMessage = "O nome é obrigatório."
           return
       }
       guard !email.isEmpty else {
           errorMessage = "O e-mail é obrigatório."
           return
       }
       guard password == confirmPassword else {
           errorMessage = "As senhas não coincidem."
           return
       }

       let calendar = Calendar.current
       let age = calendar.dateComponents([.year], from: birthDate, to: Date()).year ?? 0
       guard age >= 18 else {
           errorMessage = "Você deve ter pelo menos 18 anos."
           return
       }

       errorMessage = nil
       print("Conta criada com sucesso para \(name)!")
   }
}


// 🔹 Tela Principal Após o Login
struct ContentView: View {
   @EnvironmentObject var authViewModel: AuthViewModel
   var body: some View {
       VStack(spacing: 30) {


           Button("Sair") {
               authViewModel.logout()
           }
           .foregroundColor(.red)
           .padding()

           Spacer()
       }
       .padding()
   }
}
