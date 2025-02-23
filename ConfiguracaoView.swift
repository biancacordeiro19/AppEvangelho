import SwiftUI

struct tela01: View {
    @State private var username: String = "João da Silva"
    @State private var email: String = "joao.silva@email.com"
    @State private var showMenu: Bool = false // Controla a exibição do menu

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 30) {
                    HStack {
                        Button(action: {
                            showMenu.toggle() // Alterna o menu
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.purple)
                        }
                        Spacer()
                    }
                    .padding(.leading)

                    Text("Bem-vindo!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    Text("Fortaleça sua fé e encontre esperança em cada passo com Cristo.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    HStack(spacing: 20) {
                        NavigationLink(destination: EvangelhoView()) {
                            optionCard(title: "Evangelho do Dia", color: .blue, iconName: "book")
                        }

                        NavigationLink(destination: PerguntasView()) {
                            optionCard(title: "Perguntas", color: .green, iconName: "questionmark.circle")
                        }
                    }

                    HStack(spacing: 20) {
                        NavigationLink(destination: configuracaoView()) { // Aqui está a ligação correta
                            optionCard(title: "Configuraçao", color: .yellow, iconName: "gear")
                        }

                        NavigationLink(destination: entrarView()) {
                            optionCard(title: "Sair", color: .red, iconName: "arrow.right.square")
                        }
                    }

                    Spacer()
                }
                .padding()

                // Menu Lateral
                if showMenu {
                    menuView(username: username, email: email, onDismiss: {
                        showMenu = false // Fecha o menu ao clicar fora
                    })
                }
            }
        }
    }
}

// Menu Lateral
struct menuView: View {
    var username: String
    var email: String
    var onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.purple)

                VStack(alignment: .leading) {
                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 10)
            }
            .padding()

            Divider()

            // Opções do Menu
            VStack(alignment: .leading, spacing: 15) {
                Button(action: {
                    // Ação para Evangelho do Dia
                }) {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.blue)
                        Text("Evangelho do Dia")
                    }
                }

                Button(action: {
                    // Ação para Perguntas
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.green)
                        Text("Perguntas")
                    }
                }

                Button(action: {
                    // Ação para Configurações
                }) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.yellow)
                        Text("Configurações")
                    }
                }

                Button(action: {
                    // Ação para Sair
                }) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(.red)
                        Text("Sair")
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            Spacer()
        }
        .frame(maxWidth: 300)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            onDismiss()
        }
        .padding(.leading, 10)
    }
}

// Componente do Card de Opção
struct optionCard: View {
    let title: String
    let color: Color
    let iconName: String

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding()

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(color)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// Tela de Login com link para Criar Conta
struct lloginView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: riarContaView()) {
                    Text("Criar Conta")
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }
        }
    }
}

// Tela de Criar Conta
struct riarContaView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var birthDate: Date = Date()
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Criar Conta")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Nome completo", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Senha", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                SecureField("Confirmar senha", text: $confirmPassword)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

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
            .navigationBarTitle("Cadastro", displayMode: .inline)
        }
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

        errorMessage = nil
        print("Conta criada com sucesso para \(name)!")
    }
}

// Tela de Perguntas
struct perguntasView: View {
    var body: some View {
        VStack {
            Text("Perguntas")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

// Tela de Configurações
struct configuracaoView: View {
    var body: some View {
        VStack {
            Text("Configurações")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
    }
}

// Preview
struct tela01_Previews: PreviewProvider {
    static var previews: some View {
        tela01()
    }
}
