// Alunos: Amanda Queiroz, Carlos Hobmeier, João Freitas, Théo Nicoleli

import Foundation

// Enum que representa os tipos de mensagens possíveis.
enum TipoMensagem {
    case promocao
    case lembrete
    case alerta
}

// Enum que representa a prioridade de uma notificação.
enum PrioridadeNotificacao {
    case baixa
    case media
    case alta
}

// Struct que representa uma mensagem, com tipo e conteúdo.
struct Mensagem {
    let tipo: TipoMensagem
    let conteudo: String
}

// Protocolo que define um canal de notificação.
// Todas as notificações devem ter uma mensagem e uma prioridade.
// Além disso, devem implementar o método enviarNotificacao().
protocol Notificavel {
    var mensagem: Mensagem { get }
    var prioridade: PrioridadeNotificacao { get }
    func enviarNotificacao()
}

// Extensão do protocolo Notificavel que fornece
// uma implementação padrão para enviarNotificacao()
// e define a prioridade padrão como "baixa".
extension Notificavel {
    func enviarNotificacao() {
        print("Enviando notificação...")
    }

    var prioridade: PrioridadeNotificacao {
        return .baixa
    }
}

// Struct que representa o envio de notificações por email.
// Conforma ao protocolo Notificavel.
struct Email: Notificavel {
    let enderecoEmail: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio por email.
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando email para \(enderecoEmail): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

// Struct que representa o envio de notificações por SMS.
// Conforma ao protocolo Notificavel.
struct SMS: Notificavel {
    let numeroTelefone: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio por SMS.
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando SMS para \(numeroTelefone): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

// Struct que representa o envio de notificações via Push Notification.
// Conforma ao protocolo Notificavel.
struct PushNotification: Notificavel {
    let tokenDispositivo: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    // Implementação específica para envio via push.
    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando Push Notification para dispositivo \(tokenDispositivo): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}

// Classe que gerencia o envio de notificações.
// Inclui lógica de envio e filtragem de canais por tipo.
class SistemaNotificacoes {

    // Função genérica que filtra os canais de notificação de um tipo específico.
    func filtrarCanais<T>(canais: [Notificavel], tipo: T.Type) -> [T] {
        return canais.compactMap { $0 as? T }
    }

    // Função principal que executa o envio das notificações.
    func executar() {
        // Criação de diferentes mensagens.
        let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "PUC PR - AULA DE SWIFT")
        let mensagemLembrete = Mensagem(tipo: .lembrete, conteudo: "Comprar Whey para o João")
        let mensagemAlerta = Mensagem(tipo: .alerta, conteudo: "Lembrete de pagamento do boleto da PUC")

        // Criação de canais de notificação com diferentes mensagens e prioridades.
        let email1 = Email(enderecoEmail: "jvfdevelopment@gmail.com", mensagem: mensagemPromocao, prioridade: .media)
        let email2 = Email(enderecoEmail: "carlos.hobmeier@hotmail.com", mensagem: mensagemLembrete)
        
        let sms1 = SMS(numeroTelefone: "+55 (41) 998970828", mensagem: mensagemAlerta, prioridade: .alta)
        let sms2 = SMS(numeroTelefone: "+55 (41) 999790762", mensagem: mensagemPromocao)
        
        let push1 = PushNotification(tokenDispositivo: "TOKEN123", mensagem: mensagemLembrete, prioridade: .media)
        let push2 = PushNotification(tokenDispositivo: "TOKEN456", mensagem: mensagemAlerta)

        // Array contendo diferentes canais de notificação (protocol composition).
        let canaisNotificacao: [Notificavel] = [email1, email2, sms1, sms2, push1, push2]

        // Envio geral de notificações.
        print("Enviando notificações")
        canaisNotificacao.forEach { $0.enviarNotificacao() }

        // Filtros por tipo de canal com reenvio.
        print("\nFiltrando apenas emails")
        let apenasEmails = filtrarCanais(canais: canaisNotificacao, tipo: Email.self)
        apenasEmails.forEach { $0.enviarNotificacao() }
        print("\nFiltrando apenas SMS")
        let apenasSMS = filtrarCanais(canais: canaisNotificacao, tipo: SMS.self)
        apenasSMS.forEach { $0.enviarNotificacao() }
        print("\nFiltrando apenas PUSH")
        let apenasPush = filtrarCanais(canais:canaisNotificacao,tipo:PushNotification.self)
        apenasPush.forEach { $0.enviarNotificacao() }
    }
}

// Execução do sistema de notificações.
let sistema = SistemaNotificacoes()
sistema.executar()
