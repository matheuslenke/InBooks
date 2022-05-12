//
//  Book.swift
//  InBooks
//
//  Created by Matheus Lenke on 10/05/22.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let isbn: String
    let formato: Formato?
    let titulo: String
    let subtitulo: String?
    let anoEdicao: String?
    let preco: String?
    let imagens: [Imagens]
    let moeda: String?

    enum CodingKeys: String, CodingKey {
        case isbn, formato, titulo, subtitulo
        case anoEdicao = "ano_edicao"
        case imagens = "imagens"
        case preco, moeda
    }
    
    public init(from decoder: Decoder) throws  {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isbn = try! container.decodeIfPresent(String.self, forKey: .isbn) ?? ""
        formato = try! container.decodeIfPresent(Formato.self, forKey: .formato) ?? nil
        titulo = try! container.decodeIfPresent(String.self, forKey: .titulo) ?? ""
        subtitulo = try! container.decodeIfPresent(String.self, forKey: .subtitulo) ?? nil
        anoEdicao = try! container.decodeIfPresent(String.self, forKey: .anoEdicao) ?? nil
        preco = try! container.decodeIfPresent(String.self, forKey: .preco) ?? nil
        moeda = try! container.decodeIfPresent(String.self, forKey: .moeda) ?? nil
        
        do {
            imagens = try [container.decode(Imagens.self, forKey: .imagens)]
        } catch {
            imagens = try container.decode([Imagens].self, forKey: .imagens)
        }
    }
}

// MARK: - Catalogacao
struct Catalogacao: Codable {
    let palavrasChave, areas: String
    let cdd: String?
    let bisacPrincipal, codigoThemaCategoria, codigoThemaQualificador: [String]?

    enum CodingKeys: String, CodingKey {
        case palavrasChave = "palavras_chave"
        case areas, cdd
        case bisacPrincipal = "bisac_principal"
        case codigoThemaCategoria = "codigo_thema_categoria"
        case codigoThemaQualificador = "codigo_thema_qualificador"
    }
}

// MARK: - Contribuicao
struct Contribuicao: Codable {
    let nome, sobrenome: String
    let tipoDeContribuicao: String
    let codigoContribuicao: String

    enum CodingKeys: String, CodingKey {
        case nome, sobrenome
        case tipoDeContribuicao = "tipo_de_contribuicao"
        case codigoContribuicao = "codigo_contribuicao"
    }
}

// MARK: - Editora
struct Editora: Codable {
    let codigoEditora, nomeFantasia, cnpj: String
    let cidade: String?

    enum CodingKeys: String, CodingKey {
        case codigoEditora = "codigo_editora"
        case nomeFantasia = "nome_fantasia"
        case cnpj, cidade
    }
}

enum Formato: String, Codable {
    case book = "BOOK"
    case ebook = "EBOOK"
}

// MARK: - Imagens

struct Imagens: Codable {
    let imagemPrimeiraCapa: Imagem?
    
    enum CodingKeys: String, CodingKey {
        case imagemPrimeiraCapa = "imagem_primeira_capa"
    }
    
    
}

// MARK: - Imagem
struct Imagem: Codable {
    let pequena, media, grande: String
}

// MARK: - Medidas
struct Medidas: Codable {
    let altura, largura, espessura, peso: String?
    let paginas: String
    let encadernacao: String?
}

// MARK: - Selo
struct Selo: Codable {
    let codigoSelo, nomeDoSeloEditorial: String

    enum CodingKeys: String, CodingKey {
        case codigoSelo = "codigo_selo"
        case nomeDoSeloEditorial = "nome_do_selo_editorial"
    }
}

// MARK: - Navigation
struct Navigation: Codable {
    let page, nextPage, prevPage, totalPages: Int
    let totalRecords: Int

    enum CodingKeys: String, CodingKey {
        case page
        case nextPage = "next_page"
        case prevPage = "prev_page"
        case totalPages = "total_pages"
        case totalRecords = "total_records"
    }
}

// MARK: - Status
struct Status: Codable {
    let success: Bool
    let code: Int
}
