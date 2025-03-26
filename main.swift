
import Foundation

enum TipoMensagem {
    case promocao
    case lembrete
    case alerta
}

enum PrioridadeNotificacao {
    case baixa
    case media
    case alta
}

struct Mensagem {
    let tipo: TipoMensagem
    let conteudo: String
}

protocol Notificavel {
    var mensagem: Mensagem { get }
    var prioridade: PrioridadeNotificacao { get }
    func enviarNotificacao()
}

extension Notificavel {
    func enviarNotificacao() {
        print("Enviando notificação...")
    }

    var prioridade: PrioridadeNotificacao {
        return .baixa
    }
}

struct Email: Notificavel {
    let enderecoEmail: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando email para \(enderecoEmail): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

struct SMS: Notificavel {
    let numeroTelefone: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando SMS para \(numeroTelefone): \(mensagem.conteudo)- \(mensagem.tipo)")
    }
}

struct PushNotification: Notificavel {
    let tokenDispositivo: String
    let mensagem: Mensagem
    var prioridade: PrioridadeNotificacao = .baixa

    func enviarNotificacao() {
        let urgencia = prioridade == .alta ? "URGENTE - " : ""
        print("\(urgencia)Enviando Push Notification para dispositivo \(tokenDispositivo): \(mensagem.conteudo) - \(mensagem.tipo)")
    }
}

class SistemaNotificacoes {
    func filtrarCanais<T>(canais: [Notificavel], tipo: T.Type) -> [T] {
        return canais.compactMap { $0 as? T }
    }

    func executar() {
        let mensagemPromocao = Mensagem(tipo: .promocao, conteudo: "PUC PR - AULA DE SWIFT")
        let mensagemLembrete = Mensagem(tipo: .lembrete, conteudo: "Comprar Whey para o João")
        let mensagemAlerta = Mensagem(tipo: .alerta, conteudo: "Lembrete de pagamento do boleto da PUC")

        let email1 = Email(enderecoEmail: "jvfdevelopment@gmail.com", mensagem: mensagemPromocao, prioridade: .media)
        let email2 = Email(enderecoEmail: "carlos.hobmeier@hotmail.com", mensagem: mensagemLembrete)
        
        let sms1 = SMS(numeroTelefone: "+55 (41) 998970828", mensagem: mensagemAlerta, prioridade: .alta)
        let sms2 = SMS(numeroTelefone: "+55 (41) 999790762", mensagem: mensagemPromocao)
        
        let push1 = PushNotification(tokenDispositivo: "TOKEN123", mensagem: mensagemLembrete, prioridade: .media)
        let push2 = PushNotification(tokenDispositivo: "TOKEN456", mensagem: mensagemAlerta)

        let canaisNotificacao: [Notificavel] = [email1, email2, sms1, sms2, push1, push2]

        print("Enviando notificações")
        canaisNotificacao.forEach { $0.enviarNotificacao() }

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

let sistema = SistemaNotificacoes()
sistema.executar()
