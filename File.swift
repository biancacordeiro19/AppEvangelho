import SwiftUI


struct File: View {
    var body: some View {
        NavigationSplitView {
            sidebar()
        } detail: {
            sidebar()
        }
    }
}

struct sidebar: View {
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

struct content: View {
    var body: some View {
        Text("Bem-vindo ao Evangelho!")
            .font(.largeTitle)
            .padding()
    }
}


struct configuracoesView: View {
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


struct questionView: View {
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

struct login: View {
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
