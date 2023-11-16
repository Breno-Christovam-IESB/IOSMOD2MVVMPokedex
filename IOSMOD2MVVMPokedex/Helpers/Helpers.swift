//
//  Helpers.swift
//  IOSMOD2MVVMPokedex
//
//  Created by Breno Ramos on 16/11/23.
//

import Foundation

// Extensão do Bundle para adicionar funcionalidades de decodificação e recuperação de dados da rede
extension Bundle {
    
    // Função para decodificar dados de um arquivo JSON local no Bundle
    func decode<T: Decodable>(file: String) -> T {
        // Obtém a URL do arquivo no Bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        // Carrega os dados do arquivo
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        // Decodifica os dados usando JSONDecoder e retorna o resultado
        let decoder = JSONDecoder()
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
    
    // Função para realizar uma solicitação de rede e recuperar dados
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        // Converte a string da URL em um objeto URL
        guard let url = URL(string: url) else { return }
        
        // Cria uma tarefa de dados para realizar a solicitação de rede
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Verifica se há dados e lida com possíveis erros
            guard let data = data else {
                if let error = error { failure(error) }
                return
            }
            
            do {
                // Decodifica os dados recebidos usando JSONDecoder e chama a cláusula de conclusão
                let serverData = try JSONDecoder().decode(T.self, from: data)
                completion(serverData)
            } catch {
                // Lida com erros de decodificação chamando a cláusula de falha
                failure(error)
            }
        }.resume()  // Inicia a tarefa de dados
    }
}

